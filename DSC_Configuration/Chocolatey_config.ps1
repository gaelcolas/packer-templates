
# copy the module to install it for DSC
# Configuration keyword is before execution

Configuration "Chocolatey_Config" {

    Import-DscResource -ModuleName Chocolatey -ModuleVersion 0.0.69
    Node $ConfigurationData.AllNodes.Nodename {

        ChocolateySoftware InstallChoco {
            Ensure = 'Present'
        }

        ChocolateySetting ChocolateySetting {
            Ensure = 'Present'
            Name   = 'webRequestTimeoutSeconds'
            value  = 31
        }

        ChocolateyPackage git {
            Ensure  = 'present'
            Name    = 'git'
            Version = 'latest'
        }

        ChocolateyPackage ConEmu {
            Ensure = 'Present'
            Name   = 'ConEmu'
        }
    }
}

#Chocolatey_Config -Verbose -OutputPath C:\Configuration

#Start-DscConfiguration -Wait -Force -Verbose -Path C:\Configuration -ComputerName localhost