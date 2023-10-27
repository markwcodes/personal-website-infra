terraform {
  required_version = ">= 1.5.7, < 1.6.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.3"
    }
  }

  backend "s3" {
    endpoint                    = "syd1.digitaloceanspaces.com"
    region                      = "ap-southeast-2" # Unused field when using DigitalOcean Spaces (but required)
    key                         = "state/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

provider "digitalocean" {
  token = var.do_token
}
