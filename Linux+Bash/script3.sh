#!/bin/bash

# Get the current date and time
current_time=$(date +%Y-%m-%d_%H:%M:%S)

# Syncing directory path
sync_dir=$1

# Backup directory path
backup_dir=$2

# Log file path
log_file=backup.log

# Copy all files from the syncing directory to the backup directory
rsync -av $sync_dir $backup_dir --ignore-existing

# Find any new or deleted files in the syncing directory
new_files=$(find $sync_dir -type f -cnewer $backup_dir)
for file in $new_files; do
  echo "$current_time: Added $file" >> $log_file
done

deleted_files=$(find $backup_dir -type f ! -newer $sync_dir)
for file in $deleted_files; do
  echo "$current_time: Deleted $file" >> $log_file
done


