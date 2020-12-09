function Convert-KeyReference {
    <#
        .SYNOPSIS
            Converts Keyreferences in a string with values retrieved from a given dictionary
        .EXAMPLE
            $dict = @(
                @{
                    Key = "MyDomain"
                    Value = "Contoso"
                },
                @{
                    Key = "MyUserName"
                    Value = "Bob"
                },
                @{
                    Key = "Environment"
                    Value = "Production"
                }
            )
            $string = '$(MyDomain)\$(MyUserName)_$(Environment)'
            Convert-KeyReference -String $string -Dictionary $dict

            Expected Output: "Contoso\Bob_Production"

        .EXAMPLE
            $dict = @(
                @{
                    Key = "Server"
                    Value = "prod-001"
                },
                @{
                    Key = "Database"
                    Value = "RetailStore"
                },
                @{
                    Key = "Trusted_Connection"
                    Value = "yes"
                },
                @{
                    Key = "ConnectionString"
                    Value = 'Server=$(Server);Database=$(Database);Trusted_Connection=$(Trusted_Connection)'
                }
            )
            $string = 'ConnectionString=$(ConnectionString)'
            Convert-KeyReference -String $string -Dictionary $dict
            Expected Output: "ConnectionString=Server=prod-001;Database=RetailStore;Trusted_Connection=yes"
    #>
    [cmdletbinding()]
    param(
        [String] $String
        ,
        $Dictionary
        ,
        [String] $Prefix = '\$\('
        ,
        [String] $Suffix = '\)'
        ,
        [int] $Cycle = 0
    )
    if ($Cycle -ge 5) {
        Return
    }
    $stringOutput = $string
    $references = Get-KeyReference -String $string -Regex "$Prefix[\w.]*$Suffix"
    if (-not $references) {
        Return $stringOutput
    }
    $references | Foreach-Object {
        $refKey = $_
        $refValue = ($Dictionary | Where-Object {$_.key -eq $refkey}).Value
        if ($refValue) {
            Write-Verbose "$refkey resolved to $refValue"
            $stringOutput = $stringOutput -replace "$Prefix$refKey$Suffix",$refValue
        }
    }
    Convert-KeyReference -String $stringOutput -Dictionary $Dictionary -Cycle ($Cycle+1)
}