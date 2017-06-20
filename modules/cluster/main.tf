variable "name"              { }
variable "region"            { default = "fra1" }

variable "droplet_image"     { default = "ubuntu-16-04-x64" }
variable "droplet_size"      { default = "512mb" }
variable "droplet_count"     { default = 1 }
variable "droplet_ssh_keys"  { default = [] }

variable "lb_prefix"         { default = "load-balancer" }

variable "rancher_server_user_data" { }
variable "rancher_host_user_data" { }

# DROPLETS
resource "digitalocean_droplet" "rancher-server" {
  name      = "${var.name}-server"
  size      = "1gb"
  image     = "${var.droplet_image}"
  region    = "${var.region}"
  ssh_keys  = ["${var.droplet_ssh_keys}"]
  user_data = "${var.rancher_server_user_data}"
}

resource "digitalocean_droplet" "rancher-host" {
  count     = "${var.droplet_count}"
  name      = "${var.name}-host-${count.index}"
  size      = "${var.droplet_size}"
  image     = "${var.droplet_image}"
  region    = "${var.region}"
  ssh_keys  = ["${var.droplet_ssh_keys}"]
  user_data = "${var.rancher_host_user_data}"
}

# LOAD BALANCER
resource "digitalocean_loadbalancer" "mod" {
  name   = "${var.name}-${var.lb_prefix}"
  region = "${var.region}"

  forwarding_rule {
    entry_port      = 80
    entry_protocol  = "http"
    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"

    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  droplet_ids = ["${digitalocean_droplet.rancher-host.*.id}"]
}
