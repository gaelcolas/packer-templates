Copy-Item -Path C:\config\DSC_Configuration\modules\* -Recurse -Destination $PSHome\modules -EA 0
. C:\config\DSC_Configuration\Chocolatey_config.ps1

Chocolatey_Config -Verbose -OutputPath C:\Configuration -ConfigurationData @{
    AllNodes = @(
        @{NodeName = 'localhost'}
    )
}

Start-DscConfiguration -Wait -Force -Verbose -Path C:\Configuration -ComputerName localhost