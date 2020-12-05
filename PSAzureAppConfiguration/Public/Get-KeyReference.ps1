function Get-KeyReference {
    param(
        $string = 'Server=$(Lookup.Database.Server);Database=$(Lookup.Database.Name);Trusted_Connection=Yes'
        ,
        $regex = '\$\([\w.]*\)'
    )
    $references = ($string | select-string -pattern $regex -AllMatches).Matches.Value
    if ($references) {
        $references.replace('$(','').replace(')','')
    }
}