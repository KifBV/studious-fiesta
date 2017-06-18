variable do_token         { }
variable public_key       {  }
variable region           { default = "fra1" }

variable etcd_image { default = "coreos-stable" }
variable etcd_size  { }
variable etcd_nodes { }
#variable etcd_user_data {
#default = <<EOF
##cloud-config
#
#coreos:
#  etcd2:
#    # generate a new token for each unique cluster from https://discovery.etcd.io/new?size=3
#    discovery: "https://discovery.etcd.io/53f3aa4c3ad48cee86d94e06d45a6d33"
#    # multi-region and multi-cloud deployments need to use $public_ipv4
#    advertise-client-urls: "http://$public_ipv4:2379"
#    initial-advertise-peer-urls: "http://$private_ipv4:2380"
#    # listen only on the official ports
#    listen-client-urls: "http://0.0.0.0:2379"
#    listen-peer-urls: "http://$private_ipv4:2380"
#  units:
#    - name: "etcd2.service"
#      enable: true
#      command: "start"
#EOF
#}
