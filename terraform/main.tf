resource "digitalocean_project" "project" {
  name        = format("%s %s", var.friendly_app_name, var.environment)
  environment = var.environment
}

resource "digitalocean_project_resources" "resources" {
  project = digitalocean_project.project.id
  # Add all of the following resource types to the project: 
  # AppPlatformApp, Bucket, Database, Domain, DomainRecord, Droplet, Firewall, FloatingIp, Image, Kubernetes, LoadBalancer, MarketplaceApp, Saas, Volume
  resources = [
    digitalocean_domain.primary_domain.urn,
    digitalocean_kubernetes_cluster.cluster.urn,
  ]
}

resource "digitalocean_domain" "primary_domain" {
  name = var.primary_domain
}

resource "digitalocean_certificate" "primary_domain_cert" {
  name = format("%s-%s", var.environment, var.primary_domain)
  type    = "lets_encrypt"
  domains = [var.primary_domain]
}

resource "digitalocean_vpc" "vpc" {
  name     = format("%s-network-%s", var.app_name, var.environment)
  region   = var.region
  ip_range = var.vpc_ip_range
}

data "digitalocean_kubernetes_versions" "this" {
  version_prefix = var.kubernetes_version
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name     = format("%s-%s", var.app_name, var.environment)
  region   = var.region
  vpc_uuid = digitalocean_vpc.vpc.id

  version       = data.digitalocean_kubernetes_versions.this.latest_version
  auto_upgrade  = true
  surge_upgrade = true

  maintenance_policy {
    start_time = "04:00"
    day        = "sunday"
  }

  node_pool {
    name       = format("%s-%s-core", var.app_name, var.environment)
    size       = var.node_pool_droplet_size
    auto_scale = var.node_pool_auto_scale
    node_count = 1
    min_nodes  = var.node_pool_min_nodes
    max_nodes  = var.node_pool_max_nodes
  }
}

resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = var.argocd_chart_version
  create_namespace = true

  values = [
    file("argocd/config.yaml")
  ]
}

resource "helm_release" "argocd_app" {
  name = var.app_name

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  namespace  = "argocd"
  version    = var.argocd_apps_chart_version

  values = [
    file("argocd/markwcodes.yaml")
  ]

  set {
    name  = "applications[0].source.targetRevision"
    value = var.environment
  }

  set {
    name  = "applications[0].destination.namespace"
    value = var.environment
  }
  
  set {
    name  = "applications[0].info[0].value"
    value = "https://${var.primary_domain}"
  }
}