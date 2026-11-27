// infra/main.bicep: BusyHamster on Azure (chapters 9 and 11).
// 🧪 Written from the docs for the course; not validated with `bicep build` or
// deployed by the author. Run `az bicep lint` and a what-if before using it, and
// check API versions and property names against current Azure docs.
//
// Static Web Apps (Standard, required for a linked backend)
//   └─ /api/* ─▶ Container App (ASP.NET Core BFF + API, scales to zero)
//                  ├─ Azure SQL Database (serverless, free offer, auto-pause)
//                  └─ Key Vault (Entra External ID client secret)
// Agents never deploy this: it's tier 2, previewed with what-if on PRs and
// deployed by the "production-infra" environment after a human approves.

targetScope = 'resourceGroup'

@description('Short name used in resource names.')
param appName string = 'busyhamster'

@description('Region for everything except Static Web Apps.')
param location string = resourceGroup().location

@description('Static Web Apps is only available in some regions.')
param swaLocation string = 'westeurope'

@description('Object ID of the Entra group that administers Azure SQL (your deploy identity is a member).')
param sqlAdminGroupObjectId string

@description('Display name of that Entra group.')
param sqlAdminGroupName string

@description('Container image to run. The deploy workflow updates it on every release.')
param apiImage string = 'mcr.microsoft.com/dotnet/samples:aspnetapp'

@description('Entra External ID settings for the BFF (not secrets).')
param entraInstance string
param entraTenantId string
param entraClientId string

var suffix = uniqueString(resourceGroup().id)

// --- Observability ---------------------------------------------------------

resource logs 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: '${appName}-logs'
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
  }
}

// --- Identity for the API ----------------------------------------------------

resource apiIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${appName}-api-id'
  location: location
}

// --- Container registry --------------------------------------------------------

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: '${appName}${suffix}'
  location: location
  sku: { name: 'Basic' }
  properties: { adminUserEnabled: false }
}

var acrPullRole = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d')

resource apiCanPull 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(acr.id, apiIdentity.id, acrPullRole)
  scope: acr
  properties: {
    roleDefinitionId: acrPullRole
    principalId: apiIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

// --- Key Vault (the BFF's client secret) -----------------------------------

resource vault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: '${appName}-kv-${take(suffix, 6)}'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: { family: 'A', name: 'standard' }
    enableRbacAuthorization: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 30
    enablePurgeProtection: true
  }
}

var secretsUserRole = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6')

resource apiCanReadSecrets 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(vault.id, apiIdentity.id, secretsUserRole)
  scope: vault
  properties: {
    roleDefinitionId: secretsUserRole
    principalId: apiIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

// The secret value is set by a human (az keyvault secret set), never in this file.

// --- Azure SQL: serverless, free offer, Entra-only authentication -------------

resource sql 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${appName}-sql-${take(suffix, 6)}'
  location: location
  properties: {
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: true
      login: sqlAdminGroupName
      sid: sqlAdminGroupObjectId
      tenantId: subscription().tenantId
      principalType: 'Group'
    }
  }
}

resource allowAzure 'Microsoft.Sql/servers/firewallRules@2023-08-01-preview' = {
  parent: sql
  name: 'AllowAzureServices'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource db 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: sql
  name: appName
  location: location
  sku: {
    name: 'GP_S_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 2
  }
  properties: {
    useFreeLimit: true
    // When the monthly free amount runs out: pause until next month, never bill.
    freeLimitExhaustionBehavior: 'AutoPause'
    autoPauseDelay: 60
    minCapacity: json('0.5')
    maxSizeBytes: 34359738368 // 32 GB
  }
}

// The API's identity becomes a database user in a migration-run script:
//   CREATE USER [busyhamster-api-id] FROM EXTERNAL PROVIDER;
//   ALTER ROLE db_datareader ADD MEMBER [busyhamster-api-id];
//   ALTER ROLE db_datawriter ADD MEMBER [busyhamster-api-id];

// --- Container Apps -------------------------------------------------------

resource env 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: '${appName}-env'
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logs.properties.customerId
        sharedKey: logs.listKeys().primarySharedKey
      }
    }
  }
}

resource api 'Microsoft.App/containerApps@2024-03-01' = {
  name: '${appName}-api'
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: { '${apiIdentity.id}': {} }
  }
  properties: {
    managedEnvironmentId: env.id
    configuration: {
      activeRevisionsMode: 'Multiple' // keep the previous revision for one-command rollback
      ingress: {
        external: true
        targetPort: 8080
        transport: 'auto'
      }
      registries: [
        { server: acr.properties.loginServer, identity: apiIdentity.id }
      ]
      secrets: [
        {
          name: 'entra-client-secret'
          keyVaultUrl: '${vault.properties.vaultUri}secrets/entra-client-secret'
          identity: apiIdentity.id
        }
      ]
    }
    template: {
      containers: [
        {
          name: 'api'
          image: apiImage
          resources: { cpu: json('0.25'), memory: '0.5Gi' }
          env: [
            { name: 'ASPNETCORE_FORWARDEDHEADERS_ENABLED', value: 'true' }
            { name: 'AZURE_CLIENT_ID', value: apiIdentity.properties.clientId }
            { name: 'EntraExternalId__Instance', value: entraInstance }
            { name: 'EntraExternalId__TenantId', value: entraTenantId }
            { name: 'EntraExternalId__ClientId', value: entraClientId }
            { name: 'EntraExternalId__ClientSecret', secretRef: 'entra-client-secret' }
            {
              name: 'ConnectionStrings__Sql'
              value: 'Server=tcp:${sql.properties.fullyQualifiedDomainName},1433;Database=${db.name};Authentication=Active Directory Managed Identity;User Id=${apiIdentity.properties.clientId};Encrypt=True;'
            }
            { name: 'Flags__Sync', value: 'false' }
          ]
        }
      ]
      scale: {
        minReplicas: 0 // scale to zero: no charge while idle
        maxReplicas: 3
        rules: [
          { name: 'http', http: { metadata: { concurrentRequests: '50' } } }
        ]
      }
    }
  }
  dependsOn: [ apiCanPull, apiCanReadSecrets ]
}

// --- Static Web Apps, with the Container App as the linked /api backend -------

resource swa 'Microsoft.Web/staticSites@2023-01-01' = {
  name: '${appName}-web'
  location: swaLocation
  sku: { name: 'Standard', tier: 'Standard' } // the Free plan can't link a Container App
  properties: {
    // Deployed by the GitHub workflow with a deployment token, not from a linked repo.
    provider: 'Custom'
    stagingEnvironmentPolicy: 'Enabled'
  }
}

resource linkedApi 'Microsoft.Web/staticSites/linkedBackends@2023-01-01' = {
  parent: swa
  name: 'api'
  properties: {
    backendResourceId: api.id
    region: location
  }
}

output webHostname string = swa.properties.defaultHostname
output apiFqdn string = api.properties.configuration.ingress.fqdn
output acrLoginServer string = acr.properties.loginServer
output apiIdentityClientId string = apiIdentity.properties.clientId
