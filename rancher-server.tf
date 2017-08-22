module "rancher" {
  source    = "./modules/rancher"
  name      = "rancher"
  region    = "${var.region}"
  image     = "${var.rancher_image}"
  size      = "${var.rancher_size}"
  count     = "${var.rancher_count}"
  user_data = "${var.rancher_user_data}"
  ssh_keys  = ["${digitalocean_ssh_key.default.fingerprint}"]
}

output "Rancher Server IP: " {
  value = "${module.rancher.ip}"
}
