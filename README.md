# PSAzureAppConfiguration

A PowerShell Module for retrieving keys and secrets from an Azure App Configuration store.

Yes I'm fully aware that there already is a [PowerShell module available](https://docs.microsoft.com/en-us/powershell/module/az.appconfiguration/?view=azps-5.5.0#app-configuration) for Azure App Configuration, however this module is limited to administration only, no retrieving key/values or secrets.

My module is using the az cli as backend, which does retrieve values and secrets. But it doesn't support references to other keys natively.

Consider the following **keyvalue** pair:

key: `Connectionstring`

value: `Server=$(Server);Database=$(Database);Trusted_Connection=$(Trusted_Connection)"`

When you `list` the keyvalue using `az appconfig`, you would get:  
`Server=$(Server);Database=$(Database);Trusted_Connection=$(Trusted_Connection)`  
even though you have the keys `Server`, `Database` and `Trusted_Connection` available.

Using this modules `Get-AppConfigurationKeyValue` will give you the values of the referenced keys aswell:  

`$MyConfig = Get-AppConfigurationKeyValue -Store MyAppConfigStore -Label Production`  
`$MyConfig | Where-Object {$_.key -eq 'ConnectionString'}`  
`"ConnectionString=Server=prod-001;Database=RetailStore;Trusted_Connection=yes"`

✋ *make sure the referenced keys are fetched too when using a `-Label` or `-Key` filter*

**Prerequisites:**
- azure cli installed
- a service principle [set up](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli)
## Install module
From PowerShell, using the the PSGallery:

`Install-module PSAzureAppConfiguration`

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
