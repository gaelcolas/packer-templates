Param (
    [CmdletBinding()]

    [string]
    $VmName,

    [switch]
    $PromptOnError,

    [string]
    $IsoUrl,

    [switch]
    $Force,

    [string]
    $PackerTemplate = '.\win2019_RAW.json',

    [switch]
    $Export,

    [switch]
    $timeStamp,

    [switch]
    $Log
)

# the ovftool is required when using the vmware post-processor
if (($Env:Path -split ';') -notContains 'OVF Tool') {
    $Env:Path += ';C:\Program Files\VMware\VMware OVF Tool'
}

$packer_options = @()
$packer_options += switch ($PSBoundParameters.Keys) {
    'Force' { '-force' }
    'PromptOnError' { '-on-error=ask' }
    'VmName' { "-var", "vmname=$VmName" }
    'timeStamp' { '-timestamp-ui' }
    'Log' { $ENV:PACKER_LOG=1}
}

if (!$Log) {
    # Make sure to turn off the logs from previous run
    $ENV:PACKER_LOG = 0
}

if ($IsoUrl) {
    $packer_options += "-var", "iso_url=$IsoUrl"
}

if ($Export) {
    $packer_options += "-var", "skip_export=false"
}
else {
    $packer_options += "-var", "skip_export=true"
}

$packer_params = @('build') + $packer_options + $PackerTemplate

Write-Warning ('packer.exe {0}' -f ($packer_params -join ' '))

packer.exe $packer_params