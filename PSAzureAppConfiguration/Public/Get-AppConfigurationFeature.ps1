function Get-AppConfigurationFeature {
    <#
        .SYNOPSIS
            Lists features from an Azure App Configuration
        .EXAMPLE
            Get-AppConfigurationFeature -Store $Store
    #>
    [cmdletbinding()]
    param(
        [string] $Feature = '*'
        ,
        [parameter(Mandatory)]
        [string] $Store
        ,
        [string] $Label = '*'
        ,
        [switch] $ExcludeNoLabel
    )
    $labelQuery = "\0,$Label"
    if ( -not $PSBoundParameters.ExcludeNoLabel ) {
        $labelQuery = "$Label"
    }
    $features = az appconfig feature list --name $Store --label $labelQuery --feature $Feature  | ConvertFrom-Json
    # when multiple keys are returned, keep the one with the label
    $Output = $features | Group-object -Property Key | ForEach-Object {
        $_.Group | Sort-Object -Property Label -Descending | Select-Object -First 1
    }
    foreach ($kv in $Output) {
        $value = $kv.state
        Write-Output @{ $kv.key = $value}
    }
}