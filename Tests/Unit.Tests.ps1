
BeforeAll {
    $here = $PSScriptRoot
    $global:moduleName = 'PSAzureAppConfiguration'

    $global:projectRoot = (Resolve-Path $here/..).Path
    $moduleOutputPath = (Join-Path -Path $projectRoot -ChildPath Output\$moduleName)
    Write-Host "Checking existing output in: " $moduleOutputPath
    $global:Module = Import-Module $moduleOutputPath -Force -PassThru -ErrorAction SilentlyContinue
    if (-not $module) {
        Write-Warning "No importable module found, building.."
        $modulePath = "$projectRoot\$moduleName\$moduleName.psm1"
        Write-Host $modulePath
        $global:Module = Import-Module $modulePath -PassThru -Force
        $Module
    }
    $global:ExportedCommands = $Module.ExportedCommands.GetEnumerator() | ForEach-Object { $_.Key }
    Write-Host $ExportedCommands
}

Describe 'Build Output' {
    BeforeAll {
        $global:publicFiles = Get-ChildItem -Path "$projectRoot\$moduleName\Public" -File
    }
    it 'should have ExportedCommands' {
        $ExportedCommands | Should -Not -Be -$null
    }
    it 'public functions should match exported commands' {
        $numberOfPublicFunctionFiles = ($publicFiles | Measure-Object).Count
        $ExportedCommands.Count | Should -Be $numberOfPublicFunctionFiles
    }
}
Describe 'Comment Based Examples' {
    BeforeAll {
        $scriptPath = 'https://raw.githubusercontent.com/mieel/snippets/master/powershell/Get-CommandHelpExample.ps1'
        $script = (New-Object System.Net.WebClient).DownloadString($scriptPath)
        Invoke-Expression $script
    }
    ForEach ($command in $ExportedCommands) {
        Write-Verbose $Command
        $global:example = Get-CommandHelpExample $command
        if ($null -ne $example.Assertion) {
            it "$command - assert expected output in help example" {
                ## Test the code block if Expected Output is specified
                $expectedOutput = Invoke-Expression ($Example.Assertion | Out-String)
                $actualOutput = Invoke-Expression $Example.Scriptblock

                $actualOutput | Should -Be $expectedOutput

            }
        } else {
            Write-Verbose 'no expected output found'
        }
    }
}
Describe 'Get-KeyReference' {

}