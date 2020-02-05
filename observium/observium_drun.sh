#! /bin/bash
docker run -d -v /opt/observium/volumes/config:/config -v /opt/observium/volumes/logs:/opt/observium/logs -v /opt/observium/volumes/rrd:/opt/observium/rrd -e TZ="America/Los_Angeles" -p 8668:8668 lbreinig/observium --name observium observium
