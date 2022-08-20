#!/bin/bash
## backup.sh
## Backup all my data to my drive

backup_path=/run/media/mothinx/BACKUP

if [ ! -d $backup_path ]; then
    echo "Please connect your drive"
    exit -1
fi

today_dir=$(date +'%m%d%Y')

if [ ! -d $backup_path/$today_dir ]; then
    echo "Creating directory: $backup_path/$today_dir"
    mkdir $backup_path/$today_dir
fi

rclone copy remote: $backup_path/$today_dir
echo "Backup finish"
