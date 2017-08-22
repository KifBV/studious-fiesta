# these variable are passed at runtime
variable do_token {}
variable db_password {}

# these variables are 'global' defaults
variable region {
  default = "fra1"
}
variable rancher_image {
  default = "ubuntu-16-04-x64"
}
variable db_image {
  default = "coreos-stable"
}
variable db_version {
  default = "5.7"
}
variable db_mountpoint {
  default = "/var/lib/mysql"
}
variable rancher_user_data {
  default = <<EOF
#!/bin/bash
apt-get remove docker docker-engine
curl https://releases.rancher.com/install-docker/1.12.sh | sh
docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable
EOF
}

# these variables will come from an env. specific var. file
variable public_key {}
variable rancher_size {
  description = "The Rancher host needs at least 1gb!"
}
variable db_size {}
variable rancher_count {}
