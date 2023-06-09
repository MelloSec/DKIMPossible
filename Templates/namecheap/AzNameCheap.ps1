[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $domain = "papashells.com"
)

# Install Modules
Install-Module -Name MSOnline -Confirm:$false -Force
Import-Module MSOnline

Install-Module -Name ExchangeOnlineManagement -Confirm:$false -Force 
Import-Module ExchangeOnlineManagement

# Connect to MSOL and Exchange Online
Connect-MsolService
Connect-ExchangeOnline 

# Check the tenant domains

function Create-Domain($domain){
    if(!(Get-MsolDomain -domainname $domain))
{
    Write-Host "Domain not found, creating new custom domain"
    New-MsolDomain -Name $domain
}
Get-MsolDomainVerificationDns -DomainName $domain -Mode DnsTxTRecord
}
Create-Domain $domain

Read-Host "Update the data value for your domain in main.tf's first record, then continue.."
# Linux
# export GODADDY_API_KEY=""
# export GODADDY_API_SECRET=""

# will ask for API creds
terraform init
terraform plan
terraform apply

# Need to figure out how to generate the DKIM keys and enable without using the gui, not sure if its working
# Go to security.microsoft.com/dkim2 and generate keys 
# Enable DKIM for the tenant
New-DkimSigningConfig -DomainName $domain -Enabled $true