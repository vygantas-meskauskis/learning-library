// api/src/BusyHamster.Api/Program.cs: BFF + API starting point (chapter 11).
// 🧪 Written from the docs for the course; not compiled or run by the author.
// Check package names and APIs against the current Microsoft.Identity.Web and
// ASP.NET Core 10 documentation before you rely on it.
//
// Packages: Microsoft.Identity.Web, Microsoft.EntityFrameworkCore.SqlServer,
//           Microsoft.AspNetCore.OpenApi
// Configuration (appsettings / Container Apps env vars, secrets from Key Vault):
//   EntraExternalId:Instance     https://<tenant-subdomain>.ciamlogin.com/
//   EntraExternalId:TenantId     <tenant id>
//   EntraExternalId:ClientId     <app registration client id>
//   EntraExternalId:ClientSecret (Key Vault reference; never in the repo)
//   ConnectionStrings:Sql        Server=...;Authentication=Active Directory Managed Identity;...
//
// Not included here: BusyHamsterDb, the Task and User entities and TaskDto
// (src/Data/ in the real project). The agent writes those from the sync spec.

using System.Security.Claims;
using BusyHamster.Api.Data;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Web;

var builder = WebApplication.CreateBuilder(args);

// --- Authentication (tier 2: src/Auth/ in the real project) -----------------

builder.Services
    .AddAuthentication(options =>
    {
        options.DefaultScheme = CookieAuthenticationDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = OpenIdConnectDefaults.AuthenticationScheme;
    })
    .AddMicrosoftIdentityWebApp(options =>
    {
        builder.Configuration.Bind("EntraExternalId", options);
        // Static Web Apps only forwards /api/*, so the callbacks must live there.
        options.CallbackPath = "/api/auth/signin-oidc";
        options.SignedOutCallbackPath = "/api/auth/signout-callback-oidc";
        options.ResponseType = "code"; // authorization code flow with PKCE
        options.SaveTokens = false;    // the API needs the identity, not Entra's tokens
    });

builder.Services.Configure<CookieAuthenticationOptions>(
    CookieAuthenticationDefaults.AuthenticationScheme, cookie =>
    {
        cookie.Cookie.Name = "__Host-bh";
        cookie.Cookie.HttpOnly = true;
        cookie.Cookie.SecurePolicy = CookieSecurePolicy.Always;
        cookie.Cookie.SameSite = SameSiteMode.Lax;
        cookie.Cookie.Path = "/";
        cookie.SlidingExpiration = true;
        cookie.ExpireTimeSpan = TimeSpan.FromDays(30);
        // An API answers 401/403; it never redirects to a login page.
        cookie.Events.OnRedirectToLogin = ctx => { ctx.Response.StatusCode = 401; return Task.CompletedTask; };
        cookie.Events.OnRedirectToAccessDenied = ctx => { ctx.Response.StatusCode = 403; return Task.CompletedTask; };
    });

builder.Services.AddAuthorization();

// --- Data -------------------------------------------------------------------

builder.Services.AddDbContext<BusyHamsterDb>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("Sql"),
        sql => sql.EnableRetryOnFailure())); // serverless SQL may be resuming from auto-pause

builder.Services.AddOpenApi(); // writes the contract at build time (see api/AGENTS.md)
builder.Services.AddProblemDetails();

var app = builder.Build();

app.UseExceptionHandler();
app.UseAuthentication();
app.UseAuthorization();

// --- Antiforgery: state-changing requests must carry X-BusyHamster: 1 --------
// Browsers can't add a custom header to a cross-site request without a CORS
// preflight, and this API never approves one. Together with SameSite=Lax
// cookies, that blocks cross-site request forgery.
app.Use(async (ctx, next) =>
{
    var method = ctx.Request.Method;
    var changesState = HttpMethods.IsPost(method) || HttpMethods.IsPut(method)
        || HttpMethods.IsDelete(method) || HttpMethods.IsPatch(method);
    var isAuthCallback = ctx.Request.Path.StartsWithSegments("/api/auth/signin-oidc")
        || ctx.Request.Path.StartsWithSegments("/api/auth/signout-callback-oidc");
    if (changesState && !isAuthCallback && ctx.Request.Headers["X-BusyHamster"] != "1")
    {
        ctx.Response.StatusCode = StatusCodes.Status400BadRequest;
        return;
    }
    await next();
});

app.MapOpenApi("/api/openapi.json");

// --- Anonymous endpoints ------------------------------------------------------

var auth = app.MapGroup("/api/auth").AllowAnonymous();

auth.MapGet("/login", (string? returnUrl) =>
    Results.Challenge(
        new AuthenticationProperties { RedirectUri = SafeLocal(returnUrl) },
        [OpenIdConnectDefaults.AuthenticationScheme]));

auth.MapPost("/logout", () =>
    Results.SignOut(
        new AuthenticationProperties { RedirectUri = "/" },
        [CookieAuthenticationDefaults.AuthenticationScheme, OpenIdConnectDefaults.AuthenticationScheme]));

app.MapGet("/api/flags", (IConfiguration config) => Results.Ok(new
{
    sync = config.GetValue("Flags:Sync", false),
})).AllowAnonymous();

// --- Signed-in endpoints ------------------------------------------------------

var api = app.MapGroup("/api").RequireAuthorization();

api.MapGet("/me", (ClaimsPrincipal user) => Results.Ok(new MeResponse(
    DisplayName: user.FindFirstValue("name") ?? "Signed in")));

api.MapGet("/tasks", async (DateTimeOffset? since, ClaimsPrincipal user, BusyHamsterDb db, CancellationToken ct) =>
{
    var userId = UserId(user);
    var rows = await db.Tasks
        .Where(t => t.UserId == userId && (since == null || t.UpdatedAt > since))
        .OrderBy(t => t.UpdatedAt)
        .Take(1000)
        .ToListAsync(ct);
    return Results.Ok(rows.Select(TaskDto.From));
});

api.MapPut("/tasks", async (TaskDto[] changes, ClaimsPrincipal user, BusyHamsterDb db, CancellationToken ct) =>
{
    if (changes.Length > 500) return Results.BadRequest("Send at most 500 tasks per request.");
    var userId = UserId(user);
    var ids = changes.Select(c => c.Id).ToArray();
    var existing = await db.Tasks
        .Where(t => t.UserId == userId && ids.Contains(t.TaskId))
        .ToDictionaryAsync(t => t.TaskId, ct);

    foreach (var change in changes)
    {
        // Last writer wins, per task (docs/specs/sync.md).
        if (existing.TryGetValue(change.Id, out var row))
        {
            if (change.UpdatedAt > row.UpdatedAt) change.ApplyTo(row);
        }
        else
        {
            db.Tasks.Add(change.ToRow(userId));
        }
    }
    await db.SaveChangesAsync(ct);
    return Results.NoContent();
});

api.MapGet("/export", async (ClaimsPrincipal user, BusyHamsterDb db, CancellationToken ct) =>
{
    var userId = UserId(user);
    var rows = await db.Tasks.Where(t => t.UserId == userId).ToListAsync(ct);
    return Results.Ok(rows.Select(TaskDto.From));
});

api.MapDelete("/account", async (HttpContext http, ClaimsPrincipal user, BusyHamsterDb db, CancellationToken ct) =>
{
    var userId = UserId(user);
    await db.Tasks.Where(t => t.UserId == userId).ExecuteDeleteAsync(ct);
    await db.Users.Where(u => u.Id == userId).ExecuteDeleteAsync(ct);
    await http.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
    return Results.NoContent();
});

app.Run();

// The user always comes from the claims, never from the request (api/AGENTS.md).
static string UserId(ClaimsPrincipal user) =>
    user.GetObjectId() ?? throw new InvalidOperationException("Signed-in user without an object id.");

// Only same-site relative paths, so /api/auth/login can't be used as an open redirect.
static string SafeLocal(string? returnUrl) =>
    returnUrl is { Length: > 0 } url && url.StartsWith('/') && !url.StartsWith("//") && !url.StartsWith("/\\")
        ? url
        : "/";

public sealed record MeResponse(string DisplayName);

// Needed so WebApplicationFactory<Program> can find the entry point in tests.
public partial class Program;
