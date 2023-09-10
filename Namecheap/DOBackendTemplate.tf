terraform {
  backend "s3" {
    bucket         = "REPLACE_BUCKET"
    key            = "REPLACE_KEY/terraform.tfstate"
    region         = "us-east-1"
    endpoint       = "nyc3.digitaloceanspaces.com"  # Replace with the appropriate endpoint for your region
    # access_key = ""
    # secret_key = ""
    skip_credentials_validation = true
    skip_metadata_api_check = true    
  }
}