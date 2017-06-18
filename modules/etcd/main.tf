variable "name"   { }
variable "region" { }

variable "image"       { }
variable "size"        { }
variable "nodes"       { }
variable "ssh_keys"    { default = [] }

# DROPLETS
# cloud-config document template to bootstrap the etcd nodes
data "template_file" "init" {
  count    = "${var.nodes}"
  template = "${file("${path.module}/init.tpl")}"
  vars {
    name = "${var.name}${count.index}"
  }
}
# droplets for etcd nodes
resource "digitalocean_droplet" "etcd_nodes" {
  count              = "${var.nodes}"
  image              = "${var.image}"
  name               = "${var.name}${count.index}"
  region             = "${var.region}"
  size               = "${var.size}"
  private_networking = "true"
  ssh_keys           = ["${var.ssh_keys}"]
  user_data          = "${element(data.template_file.init.*.rendered, count.index)}"
}

## LOAD BALANCER
# to balance traffic to the etcd nodes
#resource "digitalocean_loadbalancer" "etc_elb" {
#  name   = "${var.name}-load-balancer"
#  region = "${var.region}"
#
#  forwarding_rule {
#    entry_port      = 80
#    entry_protocol  = "http"
#    target_port     = 80
#    target_protocol = "http"
#  }
#
#  healthcheck {
#    port     = 22
#    protocol = "tcp"
#
#    healthy_threshold   = 2
#    unhealthy_threshold = 2
#  }
#
#  droplet_ids = ["${digitalocean_droplet.etcd_nodes.*.id}"]
#}
