#!/bin/bash
docker exec -it sqlserver-fulltext /bin/bash -c "./var/opt/mssql/backups/cleanup_backups.sh"