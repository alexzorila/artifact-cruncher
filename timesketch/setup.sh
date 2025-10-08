#!/bin/bash

# Elevate session
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Install Docker if missing
docker > /dev/null 2>&1 || curl -fsSL https://get.docker.com | sh
service docker start

# Install Timesketch Docker
cd /opt
curl -s -O https://raw.githubusercontent.com/google/timesketch/master/contrib/deploy_timesketch.sh
chmod 755 deploy_timesketch.sh
yes n | ./deploy_timesketch.sh
rm -rf /opt/deploy_timesketch.sh

# Start Timesketch
cd /opt/timesketch
docker compose up -d && \
	until docker ps --format "table {{.Image}} | {{.Status}}" | \
	grep opensearch | grep -m 1 "Up"; do sleep 3 ; done

# Create default user. Wait until fully started (healthy)
sudo docker compose exec timesketch-web tsctl create-user admin	--password admin

# Echo user notification
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Timesketch setup done!\n"
