# PSAzureAppConfiguration

Powershell Module for retrieving keys and secrets from an Azure App Configuration store

✅ Supports references to other keys

Prerequisites:
- azure cli installed
- a service principle [set up](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli)
## Install module
`install-module PSAzureAppConfiguration`

## Usage
Login into Azure account using a service principal
```
$clientId = 'client/app id'
$tenantId = 'tenant id'
$secret = 'client secret'

az login --service-principal --username $clientId  --password $secret --tenant $tenantId
```

Get configuration:

`$MyConfig = Get-AppConfigurationKeyValue -Store MyAppConfigStore -Label Production`
