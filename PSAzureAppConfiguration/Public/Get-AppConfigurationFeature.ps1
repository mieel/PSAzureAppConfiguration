function Get-AppConfigurationFeature {
    [cmdletbinding()]
    param(
        [string] $Feature = '*'
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
    $features = az appconfig feature list --name $Store --label \0,$Label --feature $Feature $resolveKv | ConvertFrom-Json
    # when multiple keys are returned, keep the one with the label
    $Output = $features | Group-object -Property Key | ForEach-Object {
        $_.Group | Sort-Object -Property Label -Descending | Select-Object -First 1
    }
    foreach ($kv in $Output) {
        $value = $kv.state
        Write-Output @{ $kv.key = $value}
    }
}