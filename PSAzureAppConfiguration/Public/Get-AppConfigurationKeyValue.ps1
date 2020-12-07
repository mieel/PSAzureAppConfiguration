function Get-AppConfigurationKeyValue {
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
    )
    # az appconfig kv list -h
    if (-not $NoResolveSecret) {
        $resolveKv = '--resolve-keyvault'
    }
    $keyValues = az appconfig kv list --name $Store --label \0,$Label --key $Key $resolveKv | ConvertFrom-Json
    # when multiple keys are returned, keep the one with the label
    $Output = $keyValues | Group-object -Property Key | ForEach-Object {
        $_.Group | Sort-Object -Property Label -Descending | Select-Object -First 1
    }
    foreach ($kv in $Output) {
        $value = $kv.value
        if ($ConvertReferences) {
            $value = Convert-KeyReference -String $value -Dictionary $Output
        }
        Write-Output @{ $kv.key = $value}
    }
}