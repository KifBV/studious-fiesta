# Register the ssh key on DO
resource "digitalocean_ssh_key" "default" {
  name       = "terraform-k8s"
  public_key = "${file(var.public_key)}"
}

# Create an etcd cluster
module "etcd" {
  source    = "./modules/etcd"
  name      = "etcd"
  region    = "${var.region}"
  image     = "${var.etcd_image}"
  size      = "${var.etcd_size}"
  nodes     = "${var.etcd_nodes}"
  ssh_keys  = ["${digitalocean_ssh_key.default.fingerprint}"]
}
