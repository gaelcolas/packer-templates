& C:\ProgramData\chocolatey\bin\RefreshEnv.cmd
Describe "configuration is applied" {

    It "should have chocolatey software installed" {
        Get-ChocolateyVersion | Should not BeNullOrEmpty
    }

    It "should have installed conemu" {
        Get-ChocolateyPackage ConEmu -LocalOnly | Should not BeNullOrEmpty
    }
}