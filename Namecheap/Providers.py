import argparse


# Define the command-line arguments
parser = argparse.ArgumentParser(description="Replace placeholders in a Terraform configuration file.")
parser.add_argument("config_file", help="Path to the Terraform configuration file")
parser.add_argument("-b", "--bucket", required=True, help="S3 bucket name")
parser.add_argument("-k", "--key-vault", required=True, help="Name of the keyvault containing namecheap creds")
parser.add_argument("-f", "--output_file", default="providers.tf", help="Output file name (default: providers.tf)")
# parser.add_argument("-h", "--help", action="help", help="Show this help message and exit")

# Add a custom usage example when -h is provided
parser.usage = "\nExample: python3 Providers.py ProvidersTemplate.tf -b hackerspace -k teamserver -f Providers.tf \n\n"

args = parser.parse_args()

# Read the Terraform configuration file
with open(args.config_file, "r") as file:
    terraform_config = file.read()

# Perform the replacements
terraform_config = terraform_config.replace("REPLACE_BUCKET", args.bucket)
terraform_config = terraform_config.replace("REPLACE_KEY", args.key)

# Write the modified configuration to the output file
with open(args.output_file, "w") as output_file:
    output_file.write(terraform_config)

print(f"Modified Terraform configuration saved to {args.output_file}")
