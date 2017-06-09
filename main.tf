variable droplet_count     { }
variable rancher_server_user_data { }
variable rancher_host_user_data { }

module "rancher" {
  source           = "./modules/cluster"
  name             = "rancher"
  droplet_count    = "${var.droplet_count}"
  droplet_ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
  rancher_server_user_data = "${var.rancher_server_user_data}"
  rancher_host_user_data = "${var.rancher_host_user_data}"
}
