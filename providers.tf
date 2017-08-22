# Configure the DigitalOcean Provider
provider "digitalocean" {
  # Set the variable value using -var="do_token=..." CLI option
  token = "${var.do_token}"
}
# Create a new SSH key
resource "digitalocean_ssh_key" "default" {
  name       = "terraform-rancher"
  public_key = "${file(var.public_key)}"
}
