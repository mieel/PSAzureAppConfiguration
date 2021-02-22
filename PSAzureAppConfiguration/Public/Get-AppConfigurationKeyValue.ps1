function Get-AppConfigurationKeyValue {
    <#
        .SYNOPSIS
            Gets (a) key value(s) from an Azure App Configuration Store
            perform an az login first
        .EXAMPLE
            Get-AppConfigurationKeyValue -Store $store

            Gets all key values from $store
        .EXAMPLE
            Get-AppConfigurationKeyValue -Store $store -Key Common* -ConvertReferences

            Gets all key values starting with 'Common' from $store
            and converts referenced keys
        .EXAMPLE
            $keys = Get-AppConfigurationKeyValue -Store $store -Label Development -NoResolveSecret -Verbose
            $keys

            Gets all key values with labels null or Development from $store
            does not resolve keyvault secrets
        .EXAMPLE
            Get-AppConfigurationKeyValue -Store $store -Key .appconfig.featureflag*

            Gets all feature flags
            You can also use Get-AppConfigurationFeature
        .EXAMPLE
            $keys = Get-AppConfigurationKeyValue -Store $store -Top 200 -Label Development -Verbose
            $keys

            Gets all key values with labels null or Development from $store
            Increases the max limit to 200, 100 is default
    #>
    [cmdletbinding()]
    param(
        [string] $Key = '*'
        ,
        [parameter(Mandatory)]
        [string] $Store
        ,
        [string] $Label = '*'
        ,
        [switch] $NoResolveSecret
        ,
        [switch] $ExcludeNoLabel
        ,
        [switch] $ConvertReferences
        ,
        [int] $Top
    )
    # az appconfig kv list -h
    if (-not $NoResolveSecret) {
        $resolveKv = '--resolve-keyvault'
    }
    if ($Top) {
        $limitTop = "--top $Top"
    }
    $labelQuery = Get-LabelQuery @PSBoundParameters
    $m = Measure-Command {
        $keyValues = Invoke-AzCli -Arguments "appconfig kv list --name $Store --label $labelQuery --key $Key $limitTop $resolveKv"
    }
    Write-Verbose "Loaded $($keyValues.Count) keys in $($m.TotalMilliseconds)"
    # when specifying a Label, and keep the one with the label (ignore the no-label)
    $Output = $keyValues
    if ($Label -ne '*') {
        $Output = $Output | Group-object -Property Key | ForEach-Object {
            $_.Group | Sort-Object -Property Label -Descending | Select-Object -First 1
        }
    }
    foreach ($kv in $Output) {
        $value = $kv.value
        if ($kv.key -like '.appconfig.featureflag*') {
            $value = $value | ConvertFrom-Json
        }
        if ($ConvertReferences) {
            $value = Convert-KeyReference -String $value -Dictionary $Output
        }
        Write-Output @{ $kv.key = $value}
    }
}
