#! /bin/bash
docker run \
-d \
--privileged \
--net host \
-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v etc/cobbler/settings:/etc/cobbler/settings \
-v etc/cobbler/dhcp.template:/etc/cobbler/dhcp.template \
-v var/www/cobbler/images:/var/www/cobbler/images \
-v var/www/cobbler/ks_mirror:/var/www/cobbler/ks_mirror \
-v var/www/cobbler/links:/var/www/cobbler/links \
-v var/lib/cobbler/config:/var/lib/cobbler/config \
-v var/lib/tftpboot:/var/lib/tftpboot \
-v dist/centos:/mnt:ro \
-p 69:69 \
-p 80:9080 \
-p 443:9443 \
-p 25151:25151 \
--name cobbler cobbler
