droplet_count = 1

rancher_server_user_data = <<EOF
#!/bin/bash
apt-get remove docker docker-engine
curl https://releases.rancher.com/install-docker/1.12.sh | sh
docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable
EOF

rancher_host_user_data = <<EOF
#!/bin/bash
apt-get remove docker docker-engine
curl https://releases.rancher.com/install-docker/1.12.sh | sh
EOF
