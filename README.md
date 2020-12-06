# PSAzureAppConfiguration

Powershell Module for retrieving keys and secrets from an Azure App Configuration store

✅ Supports references to other keys

So if you have a key value pair:  
`"Connectionstring": "Server=$(Server);Database=$(Database);Trusted_Connection=$(Trusted_Connection)"`

When you `list` the keyvalue using `az appconfig`, you would get:  
`Server=$(Server);Database=$(Database);Trusted_Connection=$(Trusted_Connection)`

Using this modules `Get-AppConfigurationKeyValue` will give you the values of the referenced keys aswell:  

`$MyConfig = Get-AppConfigurationKeyValue -Store MyAppConfigStore -Label Production`  
`$MyConfig | Where-Object {$_.key -eq 'ConnectionString'}`  
`"ConnectionString=Server=prod-001;Database=RetailStore;Trusted_Connection=yes"`

✋ make sure the referenced keys are fetched too when using a `-Label` or `-Key` filter

*Prerequisites:*
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
