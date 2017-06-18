provider "digitalocean" {
  # Set the variable value using -var="do_token=..." CLI option
  token = "${var.do_token}"
}
