module "db" {
  source        = "./modules/db"
  name          = "mysql"
  region        = "${var.region}"
  image         = "${var.db_image}"
  size          = "${var.db_size}"
  ssh_keys      = ["${digitalocean_ssh_key.default.fingerprint}"]
  db_mountpoint = "${var.db_mountpoint}"
  db_password   = "${var.db_password}"
  db_version    = "${var.db_version}"
}

output "DB Server IP: " {
  value = "${module.db.ip}"
}
