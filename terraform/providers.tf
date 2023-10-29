terraform {
  required_version = ">= 1.5.7, < 1.6.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.3"
    }

    helm = {
      version = "~> 2.11"
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

provider "helm" { # todo: break out into module
  kubernetes {
    host = digitalocean_kubernetes_cluster.cluster.endpoint
    token = digitalocean_kubernetes_cluster.cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate
    )
  }
}
