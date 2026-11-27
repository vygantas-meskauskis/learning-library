# api/: the BusyHamster backend

ASP.NET Core on .NET 10, minimal APIs. One app does two jobs: it's the BFF
(sign-in through Entra External ID, session cookie) and the API (sync,
account, export). It runs on Azure Container Apps behind Azure Static Web Apps,
which forwards every /api/* request to it.

## Rules

- Every route starts with /api. Static Web Apps only forwards /api/*.
- Every endpoint is in the authorised /api group, except /api/auth/* and
  /api/flags, which are explicitly AllowAnonymous.
- The signed-in user comes from the claims (`User.GetObjectId()`), never from
  the request body, route or query. Every query filters by it.
- POST, PUT and DELETE require the `X-BusyHamster: 1` header (antiforgery
  middleware). Don't add exceptions.
- Log user IDs, never emails, names or request bodies.
- No outbound HTTP calls except to Entra External ID.

## Authentication is tier 2

- Authentication, cookie and antiforgery configuration live in src/Auth/.
  Don't change them to make a test pass. In tests, use TestAuthHandler in
  tests/Support/ to sign in fake users.
- Never write token validation, password handling or crypto yourself.
  Microsoft.Identity.Web and ASP.NET Core do the protocol.

## Data

- EF Core with Azure SQL. The DbContext is in src/Data/.
- Migrations: `dotnet ef migrations add <Name>` in src/. Migrations only add
  (expand). Never drop or rename a column or table, or narrow a type, in the
  same change that stops using it. That's a separate, later issue (contract).
- You never connect to any database except the Testcontainers one in tests.
  Migrations run in production from the deploy workflow, not from you.

## Contract

- The OpenAPI document is generated at build into api/openapi.json. Commit it.
- Adding endpoints or optional fields is fine. Removing, renaming or making
  something required is a breaking change: say so in the PR description.

## Commands

| Task | Command |
|---|---|
| Build (also writes openapi.json) | dotnet build |
| Unit and integration tests (needs Docker) | dotnet test |
| Run locally | dotnet run --project src/BusyHamster.Api |
| Add a migration | dotnet ef migrations add <Name> --project src/BusyHamster.Api |
