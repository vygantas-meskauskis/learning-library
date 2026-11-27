// infra/main.bicepparam: values for main.bicep. No secrets here.
using './main.bicep'

param appName = 'busyhamster'
param sqlAdminGroupObjectId = '<entra-group-object-id>'
param sqlAdminGroupName = 'busyhamster-sql-admins'
param entraInstance = 'https://<tenant-subdomain>.ciamlogin.com/'
param entraTenantId = '<external-tenant-id>'
param entraClientId = '<app-registration-client-id>'
