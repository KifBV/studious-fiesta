#cloud-config

coreos:
  etcd2:
    # generate a new token for each unique cluster from https://discovery.etcd.io/new?size=3
    name: "${name}"
    discovery: "https://discovery.etcd.io/6f6017f13f7c0d804fe094a7e889056e"
    # multi-region and multi-cloud deployments need to use $public_ipv4
    advertise-client-urls: "http://$private_ipv4:2379"
    initial-advertise-peer-urls: "http://$private_ipv4:2380"
    # listen only on the official ports
    listen-client-urls: "http://0.0.0.0:2379"
    listen-peer-urls: "http://$private_ipv4:2380"
  units:
    - name: "etcd2.service"
      enable: true
      command: "start"
