variable "name"      { }
variable "region"    { }
variable "image"     { }
variable "size"      { }
variable "count"     { }
variable "user_data" { }
variable "ssh_keys"  { type = "list" }

variable "lb_prefix"         { default = "load-balancer" }

# DROPLETS
resource "digitalocean_droplet" "rancher_server" {
  count     = "${var.count}"
  name      = "${var.name}-server-${count.index}"
  size      = "${var.size}"
  image     = "${var.image}"
  region    = "${var.region}"
  ssh_keys  = ["${var.ssh_keys}"]
  user_data = "${var.user_data}"
}

output "ip" {
  value = "${digitalocean_droplet.rancher_server.ipv4_address}"
}

/* resource "digitalocean_droplet" "rancher-host" { */
/*   count     = "${var.droplet_count}" */
/*   name      = "${var.name}-host-${count.index}" */
/*   size      = "${var.droplet_size}" */
/*   image     = "${var.droplet_image}" */
/*   region    = "${var.region}" */
/*   ssh_keys  = ["${var.droplet_ssh_keys}"] */
/*   user_data = "${var.rancher_host_user_data}" */
/* } */

/* # LOAD BALANCER */
/* resource "digitalocean_loadbalancer" "mod" { */
/*   name   = "${var.name}-${var.lb_prefix}" */
/*   region = "${var.region}" */

/*   forwarding_rule { */
/*     entry_port      = 80 */
/*     entry_protocol  = "http" */
/*     target_port     = 80 */
/*     target_protocol = "http" */
/*   } */

/*   healthcheck { */
/*     port     = 22 */
/*     protocol = "tcp" */

/*     healthy_threshold   = 2 */
/*     unhealthy_threshold = 2 */
/*   } */

/*   droplet_ids = ["${digitalocean_droplet.rancher-host.*.id}"] */
/* } */
