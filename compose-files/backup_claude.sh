#!/bin/bash

set -euo pipefail

# Directory containing Docker Compose file
DOCKER_DIR="/home/azureuser/dify/docker"

# Backup storage directory
BACKUP_DIR="/home/azureuser/dify/docker/backup"

# Number of backups to keep
KEEP_BACKUPS=5

# Change to the Docker Compose directory
cd "$DOCKER_DIR" || exit

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Stop Docker containers
docker compose down

# Create new backup
BACKUP_FILE="volumes-$(date +"%Y%m%d_%H%M%S").tgz"
sudo tar -cvf "$BACKUP_DIR/$BACKUP_FILE" volumes

# Start Docker containers
docker compose up -d

# Remove old backups
cd "$BACKUP_DIR" || exit
ls -t volumes-*.tgz | tail -n +$((KEEP_BACKUPS + 1)) | xargs -r rm

echo "Backup completed and old backups cleaned up."