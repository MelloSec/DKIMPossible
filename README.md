# DKIMPossible

## This project provides a Terraform configuration for setting up a custom domain name in AzureAD and adding DNS records to multiple DNS providers, including GoDaddy, Namecheap, and DigitalOcean.

### The configuration sets up the following DNS records:

One TXT record for AzureAD domain verification
Two MX records for SPF and Office 365 mail protection
Two CNAME records for DKIM key setup
Five CNAME records for Office 365 services (autodiscover, sip, lyncdiscover, msoid, enterpriseregistration, and enterpriseenrollment)
One A record (for a custom IP address)
One CNAME record (for a custom subdomain)

### Requirements
- Terraform v0.13 or higher
- GoDaddy API key and secret for GoDaddy configuration
- Namecheap API key and username for Namecheap configuration
- DigitalOcean API token for DigitalOcean configuration
 

### Installation and Configuration

- Clone this repository to your local machine.
- Configure the required providers in the providers.tf file:
- GoDaddy: add your api_key and api_secret to the provider block.
- Namecheap: add your api_key and username to the provider block.
- DigitalOcean: add your do_token to the provider block.
- Set the required variables in the variables.tf file:

```
        domain_name: the name of your custom domain.
        customer_id: (GoDaddy only) the ID of the customer account.
        verification_record: the verification record given by AzureAD after adding your custom domain.
        onmicrosoft_domain: the name of your AzureAD domain.
        o365_protection: the domain name for Office 365 mail protection.
        mail_protection: the domain name for mail protection (same as o365_protection).

```

```
terraform init # to initialize the providers and download the required modules.
terraform plan # See projected changes project will make
terraform apply # to create the DNS records in all providers.
```

Verify that the DNS records have been created correctly in all providers.

### Usage
To add more DNS records or modify the existing ones, edit the record blocks in the main.tf file, then run terraform apply again to update the DNS records.

Notes
This configuration assumes that you have already set up a custom domain in AzureAD and have obtained the required verification record.
Use 'AzNameCheap.ps1' to onboard a new custom domain using powershell, create the template and run terraform.
The A record for a custom IP address is commented out by default. Uncomment it and set the data attribute to your IP address if you need to add an A record.
The mode and email_type attributes in the Namecheap provider are set to OVERWRITE and MX, respectively. Change them as needed.
This configuration only adds DNS records for Office 365 services. If you need to add DNS records for other services, add them to the main.tf file as needed.
