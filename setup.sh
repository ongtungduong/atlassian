#!/bin/bash

# Download Atlassian agent files
curl -Lo ./atlassian-agent.jar https://github.com/haxqer/jira/releases/download/v1.3.3/atlassian-agent.jar

# Set permissions for Atlassian files and data directories
find ./ -type f -exec chown 999:999 {} +
mkdir -p data/{jira,confluence} && chown -R 999:999 data/{jira,confluence}

# Start containers
docker compose up --build -d
