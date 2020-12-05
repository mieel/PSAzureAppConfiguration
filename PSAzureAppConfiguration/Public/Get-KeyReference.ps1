function Get-KeyReference {
    <#
        .SYNOPSIS
            Parses a string and extracts the tokenized strings
            Default prefix and suffix is '$(' and ')'
            Only words chars and dots are allowed as key strings
        .EXAMPLE
            $string = 'asdfsadf'
            Get-KeyReference -String 'MyServer=$(MyApp.Database.Server);Database=$(MyApp.Database.Name);Trusted_Connection=Yes'
            Expected Output: @('MyApp.Database.Server','MyApp.Database.Name')
    #>
    param(
        [string] $String
        ,
        [string] $regex = '\$\([\w.]*\)'
    )
    $references = ($string | select-string -pattern $regex -AllMatches).Matches.Value
    if ($references) {
        $references.replace('$(','').replace(')','')
    }
}