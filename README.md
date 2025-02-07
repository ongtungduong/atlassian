# Getting started

- Simply run the `setup.sh` script to download the Atlassian Agent jar file and set the proper permissions for the files and directories.

- For more information, please refer to README.md in each Atlassian product directory and docker-compose.yaml file.

## Persisting your data

- The mounted Atlassian files and directories must have the proper permissions for the UID *999* and GID *999*.

**Please setup PostgreSQL database before running the setup.sh script.**