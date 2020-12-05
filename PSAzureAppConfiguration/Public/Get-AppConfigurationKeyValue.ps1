function Get-AppConfigurationKeyValue {
    [cmdletbinding()]
    param(
        [string] $Key = '*'
        ,
        [string] $Store
        ,
        [string] $Label = '*'
        ,
        [switch] $NoResolveSecret
        ,
        [switch] $ExcludeNoLabel
    )
    # az appconfig kv list -h
    If (-not $NoResolveSecret) {
        $resolveKv = '--resolve-keyvault'
    }
    $Output = az appconfig kv list --name $Store --label \0 --key $Key $resolveKv | ConvertFrom-Json
    $Output += az appconfig kv list --name $Store --label $Label --key $Key $resolveKv | ConvertFrom-Json

    ForEach ($kv in $Output) {
        $value = $kv.value
        $value = Convert-KeyReference -String $value -Dictionary $Output
        Write-Output @{ $kv.key = $value}
    }
}