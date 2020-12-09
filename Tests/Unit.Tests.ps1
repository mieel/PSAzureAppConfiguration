BeforeAll {
    $here = $PSScriptRoot
    $global:moduleName = 'PSAzureAppConfiguration'
    Remove-Module $moduleName -ErrorAction Ignore
    $global:projectRoot = (Resolve-Path $here/..).Path
    $moduleOutputPath = (Join-Path -Path $projectRoot -ChildPath Output\$moduleName)
    Write-Host "Checking existing output in: " $moduleOutputPath
    $global:Module = Import-Module $moduleOutputPath -Force -PassThru -ErrorAction SilentlyContinue
    if (-not $module) {
        Write-Warning "No importable module found, building.."
        $modulePath = "$projectRoot\$moduleName\$moduleName.psm1"
        Write-Host Using module: [$modulePath]
        $global:Module = Import-Module $modulePath -PassThru -Force
    }
    $global:ExportedCommands = $Module.ExportedCommands.GetEnumerator() | ForEach-Object { $_.Key }
}

Describe 'Build Output' {
    BeforeAll {
        $global:publicFiles = Get-ChildItem -Path "$projectRoot\$moduleName\Public" -File
    }
    it 'should have ExportedCommands' {
        $ExportedCommands | Should -Not -Be -$null
    }
}
