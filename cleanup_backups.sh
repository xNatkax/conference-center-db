#!/bin/bash
find /var/opt/mssql/backups -type f -name "*.bak" -mtime +30 -exec rm {} \;
echo "Old backups have been removed: \$(date)" >> /var/opt/mssql/backups/cleanup_log.txt