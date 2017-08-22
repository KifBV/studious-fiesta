# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

# Create a new SSH key
resource "digitalocean_ssh_key" "default" {
  name       = "terraform-rancher"
  public_key = "${file(var.public_key)}"
}
