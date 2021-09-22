packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}


variable "image" {
  type    = string
  default = "ubuntu:xenial"
}

# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "docker" "ubuntu" {
  commit = true
  image  = "${var.image}"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.docker.ubuntu"]

  provisioner "shell" {
    inline = ["echo Hello world!"]
  }

  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }

  post-processor "docker-tag" {
  repository = "learn-packer"
  tags       = ["ubuntu-xenial"]
  }
}

