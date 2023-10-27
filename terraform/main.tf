resource "digitalocean_project" "project" {
  name        = format("%s %s", var.friendly_app_name, var.environment)
  environment = var.environment
}
