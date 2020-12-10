$moduleRoot = Resolve-Path "$PSScriptRoot"

# $moduleName = Split-Path $moduleRoot -Leaf

# Get .Tools files (functions) and dotSource them
Get-ChildItem -Path $moduleRoot/Public -recurse -filter '*.ps1' |
    ForEach-Object {. $_.FullName}

Get-ChildItem -Path $moduleRoot/Private -recurse -filter '*.ps1' |
    ForEach-Object {. $_.FullName}

Export-ModuleMember -Function *
