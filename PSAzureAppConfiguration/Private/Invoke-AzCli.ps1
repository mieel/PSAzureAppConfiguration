function Invoke-AzCli {
    <#
        .SYNOPSIS
            Wrapper for Azure cli
            Tries to convert json, otherwise raw output is returned
        .EXAMPLE
            Invoke-AzCli -Arguments "appconfig -h"
        .EXAMPLE
            Invoke-AzCli -Arguments "appconfig kv list --name $store"
    #>
    param (
        [string] $Arguments
    )
    $expression = "& az $Arguments"
    Write-Verbose "Invoking: $expression"
    $Output = Invoke-Expression $expression -ErrorAction Stop
    try {
        Write-Output $Output | ConvertFrom-Json
    } catch {
        $Output
    }
}