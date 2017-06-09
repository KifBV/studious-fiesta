# Set the variable value using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

# Create a new SSH key
resource "digitalocean_ssh_key" "default" {
  name       = "Terraform"
  public_key = "${file("keys/id_rsa_do.pub")}"
}
