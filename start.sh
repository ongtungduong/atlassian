#!/bin/bash

# Download Atlassian agent files
curl -Lo ./jira/atlassian-agent.jar https://github.com/haxqer/jira/releases/download/v1.3.3/atlassian-agent.jar
curl -Lo ./confluence/atlassian-agent.jar https://github.com/haxqer/confluence/releases/download/v1.3.3/atlassian-agent.jar

# Set permissions for Atlassian files
find ./jira ./confluence -type f -exec chown 999:999 {} +

# Create and set permissions for data directories
mkdir -p data/{postgresql,jira,confluence}
chown -R 999:999 data/{jira,confluence}
chown -R 1001:1001 data/postgresql

# Start containers
docker compose up --build -d
