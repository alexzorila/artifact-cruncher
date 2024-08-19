#!/bin/bash

# Elevate session
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Install Docker if missing
docker > /dev/null 2>&1 || curl -fsSL https://get.docker.com | sh
service docker start

# Install Splunk Docker. Wait until fully started (healthy)
docker compose up -d && \
	until docker ps --format "table {{.Image}} | {{.Status}}" | \
	grep splunk | grep -m 1 "healthy"; do sleep 1 ; done

# Apply Splunk custom config. Wait until fully started (healthy)
docker compose exec -u root splunk /bin/sh -c "/home/splunk/bootstrap.sh"
docker compose restart && \
	until docker ps --format "table {{.Image}} | {{.Status}}" | \
	grep splunk | grep -m 1 "healthy"; do sleep 1 ; done
