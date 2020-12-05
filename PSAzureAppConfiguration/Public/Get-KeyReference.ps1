function Get-KeyReference {
    param(
        $string = 'Server=$(Lookup.Database.Server);Database=$(Lookup.Database.Name);Trusted_Connection=Yes'
        ,
        $regex = '\$\([\w.]*\)'
    )
    $matches = ($string | select-string -pattern $regex -AllMatches).Matches.Value
    if ($matches) {
        $matches.replace('$(','').replace(')','')
    }
