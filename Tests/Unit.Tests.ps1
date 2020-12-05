
BeforeAll {
    $here = $PSScriptRoot
    $global:moduleName = 'PSPSAzureAppConfiguration'

    $global:projectRoot = (Resolve-Path $here/..).Path
    $moduleOutputPath = (Join-Path -Path $projectRoot -ChildPath Output\$moduleName)
    Write-Host "Checking existing output in: " $moduleOutputPath
    $global:Module = Import-Module $moduleOutputPath -Force -PassThru -ErrorAction SilentlyContinue
    if (-not $module) {
        Write-Warning "No importable module found, building.."
        $global:Module = & $projectRoot\Scripts\Invoke-Build.ps1 -ModuleName $moduleName
    }
}
Describe 'Build Output' {
    it 'should have ExportedCommands' {
        $publicFiles = Get-ChildItem -Path "$projectRoot\$moduleName\Public" -File
        $Module.ExportedCommands | Should -Not -Be -$null
        $exportedCommands = ($Module.ExportedCommands.GetEnumerator() | Measure-Object).Count
        $numberOfPublicFunctionFiles = ($publicFiles | Measure-Object).Count
        $exportedCommands | Should -Be $numberOfPublicFunctionFiles
    }
}