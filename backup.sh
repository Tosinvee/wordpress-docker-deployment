#!/bin/bash

# Name of the running MySQL container
CONTAINER_NAME=mysql-db

# Database credentials from the .env file
DB_USER=root
DB_PASSWORD=changeme
DB_NAME=wordpress

# S3 bucket name
S3_BUCKET=wordpress-backup-tosin-2026

# Generate timestamp for unique backup filename
TIMESTAMP=$(date +"%Y-%m-%d-%H%M")

# Name of backup file
BACKUP_FILE="backup-$TIMESTAMP.sql"

# Run mysqldump inside the MySQL container
docker exec $CONTAINER_NAME \
mysqldump -u$DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_FILE

# Upload backup file to S3
aws s3 cp $BACKUP_FILE s3://$S3_BUCKET/$BACKUP_FILE

# Confirm upload
echo "Backup successful!"
echo "Uploaded to: s3://$S3_BUCKET/$BACKUP_FILE"
