resource "kubernetes_config_map" "app_config_map" {
  metadata {
    name = "app-config" # todo figure how to make name dynamic 
    namespace = var.environment
  }

  data = {
    APP_NAME = var.friendly_app_name
    ASSET_URL = "https://${var.primary_domain}"
    APP_ENV = "production"
    SESSION_DRIVER = "file"
  }
}

resource "kubernetes_secret" "app_secrets" {
  metadata {
    name = "app-secrets"
    namespace = var.environment
  }

  data = {
    APP_KEY = var.app_key
    # DB_CONNECTION = "mysql"
    # DB_HOST = "mysql"
    # DB_PORT = "3306"
    # DB_DATABASE = "laravel"
    # DB_USERNAME = "username"
    # DB_PASSWORD = "password"
  }
}