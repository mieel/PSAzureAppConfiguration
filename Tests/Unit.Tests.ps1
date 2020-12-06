
$scriptPath = 'https://raw.githubusercontent.com/mieel/snippets/master/powershell/Get-CommandHelpExample.ps1'
$script = (New-Object System.Net.WebClient).DownloadString($scriptPath)
Invoke-Expression $script

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
    it 'public functions should match exported commands' {
        $numberOfPublicFunctionFiles = ($publicFiles | Measure-Object).Count
        $ExportedCommands.Count | Should -Be $numberOfPublicFunctionFiles
    }
}
Describe 'Comment Based Examples' {
    ForEach ($command in $ExportedCommands) {
        Write-Verbose $command
        $examples = Get-CommandHelpExample $command | Where-Object { $null -ne $_.Assertion }
        if ($examples) {
            it "$command - assert expected output in help example" -TestCases @($examples) {
                param(
                    [string] $Scriptblock
                    ,
                    [string] $Assertion
                )
                ## Test the code block if Expected Output is specified
                $expectedOutput = Invoke-Expression $Assertion
                $actualOutput = Invoke-Expression $Scriptblock
                $actualOutput | Should -Be $expectedOutput
            }
        } else {
            Write-Verbose 'no expected output found'
        }
    }
}