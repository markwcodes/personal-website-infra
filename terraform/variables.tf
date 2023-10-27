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