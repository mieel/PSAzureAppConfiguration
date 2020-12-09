$scriptPath = 'https://raw.githubusercontent.com/mieel/snippets/master/powershell/Get-CommandHelpExample.ps1'
$global:script = (New-Object System.Net.WebClient).DownloadString($scriptPath)
Invoke-Expression $script

. $PSScriptRoot\Init.ps1

$global:ModuleCommands = $Module.Invoke({Get-Command -Module $moduleName})

Write-Host $ModuleCommands

$CommandExamples = @()
$CommandExamples += $ModuleCommands | ForEach-Object {
    $cmd = $_
    $examples = Get-CommandHelpExample $cmd.Name | Where-Object { $null -ne $_.Assertion }
    if ($examples) {
        @{
            Command = @{
                Name = $cmd.Name
                Examples = $examples
            }
        }
    }
}
Describe "<Command.Name> Comment Based Examples" -ForEach $CommandExamples {
    it "{<_.Scriptblock>} Should return the expected output => <_.Assertion>" -ForEach @($Command.Examples) {
        ## Test the code block if Expected Output is specified
        $expectedOutput = Invoke-Expression $Assertion
        $actualOutput = Invoke-Expression $ScriptBlock
        $actualOutput | Should -Be $expectedOutput
    }
}
