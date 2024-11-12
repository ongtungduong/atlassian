# Getting started

- Simply run the `start.sh` script to download the Atlassian Agent jar file and set the proper permissions for the files and directories.

- For more information, please refer to README.md in each Atlassian product directory and docker-compose.yaml file.

## Persisting your data

- The mounted Atlassian files and directories must have the proper permissions for the UID *999* and GID *999*.

- The mounted PostgreSQL directory must have the proper permissions for the UID *1001* and GID *1001*.
