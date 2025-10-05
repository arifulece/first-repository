terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Pull Nginx image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Run Nginx container
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id   # <-- fix here
  name  = "terraform-nginx"

  ports {
    internal = 80
    external = 8081
  }
 volumes {
    host_path      = "/root/nginx_site/clothing/"
    container_path = "/usr/share/nginx/html"
  }
}

# APACHE Image & Container
resource "docker_image" "apache" {
  name         = "httpd:latest"
  keep_locally = false
}

resource "docker_container" "apache" {
  image = docker_image.apache.image_id
  name  = "terraform-apache"

  ports {
    internal = 80
    external = 8082
  }
 volumes {
    host_path      = "/root/nginx_site/catalog/"
    container_path = "/usr/local/apache2/htdocs"
  }
}
