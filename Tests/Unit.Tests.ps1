
BeforeAll {
    $here = $PSScriptRoot
    $global:moduleName = 'PSAzureAppConfiguration'

    $global:projectRoot = (Resolve-Path $here/..).Path
    $moduleOutputPath = (Join-Path -Path $projectRoot -ChildPath Output\$moduleName)
    Write-Host "Checking existing output in: " $moduleOutputPath
    $global:Module = Import-Module $moduleOutputPath -Force -PassThru -ErrorAction SilentlyContinue
    if (-not $module) {
        Write-Warning "No importable module found, building.."
        $global:Module = Import-Module $projectRoot\$moduleName -PassThru
    }
}
Describe 'Build Output' {
    BeforeAll {
        $global:publicFiles = Get-ChildItem -Path "$projectRoot\$moduleName\Public" -File
    }
    it 'should have ExportedCommands' {
        $Module.ExportedCommands | Should -Not -Be -$null
    }
    it 'public functions should match exported commands' {
        $ExportedCommands = ($Module.ExportedCommands.GetEnumerator() | Measure-Object).Count
        $numberOfPublicFunctionFiles = ($publicFiles | Measure-Object).Count
        $exportedCommands | Should -Be $numberOfPublicFunctionFiles
    }
}