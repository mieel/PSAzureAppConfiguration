$scriptPath = 'https://raw.githubusercontent.com/mieel/snippets/master/powershell/Get-CommandHelpExample.ps1'
$global:script = (New-Object System.Net.WebClient).DownloadString($scriptPath)
Invoke-Expression $script

. $PSScriptRoot\Init.ps1

Write-Host Commands: ($ExportedCommands -join ',')
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