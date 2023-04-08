terraform {
  required_providers {
    namecheap = {
      source = "namecheap/namecheap"
      version = "2.1.0"
    }
  }
}


# Namecheap API credentials
provider "namecheap" {
  user_name = "mellonaut"
  api_user = "mellonaut"
  api_key = "$API_KEY"
  client_ip = "$IP"
  use_sandbox = false
}


