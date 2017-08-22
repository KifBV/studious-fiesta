variable "name"      { }
variable "region"    { }
variable "image"     { }
variable "size"      { }
variable "ssh_keys"  { type = "list" }

variable "db_mountpoint" {}
variable "db_password" {}
variable "db_version" {}

# volume for db persistence
resource "digitalocean_volume" "db_volume" {
  region      = "${var.region}"
  name        = "${var.name}-db-volume"
  size        = 1
  description = "volume for db persistence (${var.name})"
}

# Template for initial configuration bash script
data "template_file" "init" {
  template = "${file("${path.module}/init.tpl")}"

  vars {
    db_mountpoint = "${var.db_mountpoint}"
    db_password = "${var.db_password}"
    db_version = "${var.db_version}"
  }
}

# DROPLETS
resource "digitalocean_droplet" "db_server" {
  name      = "${var.name}-server"
  size      = "${var.size}"
  image     = "${var.image}"
  region    = "${var.region}"
  ssh_keys  = ["${var.ssh_keys}"]
  user_data = "${data.template_file.init.rendered}"
  volume_ids = ["${digitalocean_volume.db_volume.id}"]
}

output "ip" {
  value = "${digitalocean_droplet.db_server.ipv4_address}"
}

