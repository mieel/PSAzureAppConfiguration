$here = $PSScriptRoot
$global:moduleName = 'PSAzureAppConfiguration'
Remove-Module $moduleName -ErrorAction Ignore
$global:projectRoot = (Resolve-Path $here/..).Path
$moduleOutputPath = (Join-Path -Path $projectRoot -ChildPath Output\$moduleName)
Write-Host "Checking existing output in: " $moduleOutputPath
$global:Module = Import-Module $moduleOutputPath\$moduleName.psm1 -Force -PassThru -ErrorAction SilentlyContinue
if (-not $module) {
    Write-Warning "No importable module found, building.."
    $global:moduleRoot = "$projectRoot\$moduleName"
    $global:modulePath = "$projectRoot\$moduleName\$moduleName.psm1"
    Write-Host Using module: [$modulePath]
    $global:Module = Import-Module $modulePath -PassThru -Force
}
