variable "do_token" {
  description = "DigitalOcean account secret token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "syd1"
}

variable "app_name" {
  description = "Computer friendly app name"
  type        = string
  default     = "markwcodes"
}

variable "friendly_app_name" {
  description = "Human friendly app name"
  type        = string
  default     = "Personal Website"
}

variable "environment" {
  description = "Deployment environment (production/staging/development)"
  type        = string
  default     = "development"
}

variable "primary_domain" {
  description = "Primary domain name"
  type        = string
}

variable "vpc_ip_range" {
  description = "The range of IP addresses for the VPC"
  type        = string
  default     = "172.16.0.0/20"
}

variable "kubernetes_version" {
  description = "Kubernetes version number prefix"
  type        = string
  default     = "1.28."
}

variable "node_pool_droplet_size" {
  description = "Node pool droplet size"
  type        = string
  default     = "s-1vcpu-2gb-amd" # Droplet sizes: https://slugs.do-api.dev/
}

variable "node_pool_auto_scale" {
  description = "Whether the node pool should auto-scale up and down based on demand"
  type        = bool
  default     = true
}

variable "node_pool_min_nodes" {
  description = "Minimum number of nodes in node pool"
  type        = number
  default     = 1
}

variable "node_pool_max_nodes" {
  description = "Maximum number of nodes in node pool"
  type        = number
  default     = 5
}

variable "argocd_chart_version" {
  description = "Argo CD 'argo-cd' Helm chart version"
  type        = string
  default     = "5.48.0"
}

variable "argocd_apps_chart_version" {
  description = "Argo CD 'argocd-apps' Helm chart version"
  type        = string
  default     = "1.4.1"
}
