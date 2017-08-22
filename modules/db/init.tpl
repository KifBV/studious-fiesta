#!/bin/bash
chcon -Rt svirt_sandbox_file_t ${db_mountpoint}
docker run -d \
  --name mysql \
  -v ${db_mountpoint}:/var/lib/my_sql \
  -e MYSQL_ROOT_PASSWORD='${db_password}' \
  -d mysql:${db_version}
