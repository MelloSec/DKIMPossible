import argparse


# Define the command-line arguments
parser = argparse.ArgumentParser(description="Replace placeholders in a Terraform configuration file.")
parser.add_argument("config_file", help="Path to the Terraform configuration file")
parser.add_argument("-d", "--domain", required=True, help="Domain name")
parser.add_argument("-t", "--tld", required=True, help="Top-level domain (TLD)")
parser.add_argument("-v", "--verification", required=True, help="Verification record")
parser.add_argument("-o", "--onmicrosoft", required=True, help="OnMicrosoft domain")
parser.add_argument("-s", "--spf", required=True, help="SPF record")
parser.add_argument("-f", "--output_file", default="main.tf", help="Output file name (default: main.tf)")
# parser.add_argument("-h", "--help", action="help", help="Show this help message and exit")

# Add a custom usage example when -h is provided
parser.usage = "\nExample: python Templater.py NewNameCheapTemplate.tf -d example -t com -v 57679485 -o 17f2g -s mail -f newtemplate.tf \n\n"

args = parser.parse_args()

# Read the Terraform configuration file
with open(args.config_file, "r") as file:
    terraform_config = file.read()

# Perform the replacements
terraform_config = terraform_config.replace("REPLACE_DOMAIN", args.domain)
terraform_config = terraform_config.replace("REPLACE_TLD", args.tld)
terraform_config = terraform_config.replace("REPLACE_VERIFICATION", args.verification)
terraform_config = terraform_config.replace("REPLACE_ONMICROSOFT", args.onmicrosoft)
terraform_config = terraform_config.replace("REPLACE_SPF", args.spf)

# Write the modified configuration to the output file
with open(args.output_file, "w") as output_file:
    output_file.write(terraform_config)

print(f"Modified Terraform configuration saved to {args.output_file}")
