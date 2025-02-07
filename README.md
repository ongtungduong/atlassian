# Getting started

## Change permissions for Atlassian files and data directories

```bash
find ./ -type f -exec chown 999:999 {} +
mkdir -p data/{jira,confluence} && chown -R 999:999 data/{jira,confluence}
```

## Get Atlassian Agent

For more information, please refer to README.md in each Atlassian product directory.

## Proxy name

Change the `proxyName` in the `server.xml` file in each Atlassian product directory to your domain name.

**Please setup PostgreSQL database manually.**