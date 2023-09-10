[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $providerTemp= "ProviderTemplate.tf",
    [Parameter()]
    [string]
    $backendTemp= "BackendTemplate.tf",
    [Parameter()]
    [string]
    $backendFile= "backend.tf",
    [Parameter()]
    [string]
    $providerFile= "provider.tf",
    [Parameter()]
    [string]
    $keyVault= "",
    [Parameter()]
    [string]
    $group= "",
    [Parameter()]
    [string]
    $bucket= "",
    [Parameter()]
    [string]
    $key= ""

)

Write-Output "Creating $providerFile for providers using the template $providersTemp"
python3 Providers.py $providersTemp -g $group -k $keyVault -f $providerFile

Write-Output "Creating $backendFile for providers using the template $backendTemp"
python3 Backend.py $backendTemp -b $bucket -k $key -f $backendFile

