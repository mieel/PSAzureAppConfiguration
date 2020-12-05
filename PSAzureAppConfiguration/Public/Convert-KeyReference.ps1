function Convert-KeyReference {
    [cmdletbinding()]
    param(
        $String
        ,
        $Dictionary
        ,
        $Prefix = '\$\('
        ,
        $Suffix = '\)'
    )
    $stringOutput = $string
    $references = Get-KeyReference -String $string -Regex "$Prefix[\w.]*$Suffix"
    if (-not $references) {
        Return $stringOutput
    }
    $references | Foreach-Object {
        $refKey = $_
        $refValue = ($Dictionary | Where-Object {$_.key -eq $refkey}).Value
        Write-Verbose "$refkey resolved to $refValue"
        $stringOutput = $stringOutput -replace "$Prefix$refKey$Suffix",$refValue
    }
    Convert-KeyReference -String $stringOutput -Dictionary $Dictionary
}