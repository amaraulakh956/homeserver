#!/bin/bash

# Home Server Backup Script
# Backs up all Docker volumes and compose files

BACKUP_DIR="/opt/backups"
DATE=$(date +%Y-%m-%d)
STACKS_DIR="/opt/stacks"

echo "Starting backup — $DATE"

# Create backup directory
mkdir -p "$BACKUP_DIR/$DATE"

# Backup all compose files
echo "Backing up compose files..."
cp -r "$STACKS_DIR" "$BACKUP_DIR/$DATE/stacks"

# Backup Docker volumes for each service
SERVICES=("navidrome" "nextcloud" "adguard" "portainer" "uptime-kuma" "homarr" "bazarr" "radarr" "sonarr" "prowlarr")

for SERVICE in "${SERVICES[@]}"; do
    echo "Backing up $SERVICE..."
    tar -czf "$BACKUP_DIR/$DATE/$SERVICE.tar.gz" "$STACKS_DIR/$SERVICE"
done

# Remove backups older than 7 days
echo "Cleaning old backups..."
find "$BACKUP_DIR" -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;

echo "Backup complete — saved to $BACKUP_DIR/$DATE"
