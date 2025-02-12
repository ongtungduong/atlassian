# Atlassian Docker

## Persisting your data

Files and directories must have the proper permissions for the UID and GID 999.

```bash
mkdir -p data/{jira,confluence} && chown -R 999:999 data/{jira,confluence}
find ./ -type f -exec chown 999:999 {} +
```

## Notes

- Create PostgreSQL database for Jira and Confluence.

- Change the `proxyName` in the `server.xml` file in each Atlassian product directory to your domain name.

- Review the `docker-compose.yaml` file before running.
