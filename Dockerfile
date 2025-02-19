FROM mcr.microsoft.com/mssql/server:2022-latest

# Switch to root to install fulltext - apt-get won't work unless you switch users!
USER root

# Install dependencies - these are required to make changes to apt-get below
RUN apt-get update && \
    apt-get install -yq gnupg gnupg2 gnupg1 curl apt-transport-https cron && \
# Install SQL Server package links - why aren't these already embedded in the image?  How weird.
    curl https://packages.microsoft.com/keys/microsoft.asc -o /var/opt/mssql/ms-key.cer && \
    apt-key add /var/opt/mssql/ms-key.cer && \
    curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list -o /etc/apt/sources.list.d/mssql-server-2022.list && \
    apt-get update && \
# Install SQL Server full-text-search - this only works if you add the packages references into apt-get above
    apt-get install -y mssql-server-fts && \
# Cleanup - remove the links to Microsoft packages that we added earlier
    apt-get clean && \
    rm -rf /var/lib/apt/lists

COPY cleanup_backups.sh /root/cleanup_backups.sh
COPY backups-cron /etc/cron.d/backups-cron
RUN chmod 644 /etc/cron.d/backups-cron && crontab /etc/cron.d/backups-cron

# Run SQL Server process
ENTRYPOINT [ "/opt/mssql/bin/sqlservr" ]
