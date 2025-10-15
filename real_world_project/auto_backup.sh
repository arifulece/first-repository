#!/bin/bash
source_dir="/var/www/html"
backup_dir="/home/automation/backup"
remote_user="automation"

DATE=$(date '+%Y-%m-%d %H-%M-%S')
BACKUP_FILE="$backup_dir/backup_$DATE.tar.gz"
LOGFILE="/var/log/backup.log"
RETENTION_DAYS=7

echo "======================" >> $LOGFILE
echo "Source: $source_dir" >> $LOGFILE
echo "Backup File: $BACKUP_FILE" >> $LOGFILE

tar -czf $BACKUP_FILE $source_dir 2>> $LOGFILE

if [ $? -eq 0 ];then
	echo "[ok] backup complete successfully" >> $LOGFILE
else
	echo "[error] backup failed" >> $LOGFILE
fi
# ==== Delete old backups ====
find $backup_dir -type f -mtime +$RETENTION_DAYS -name "backup_*.tar.gz" -exec rm -f {} \;
echo "[INFO] Old backups older than $RETENTION_DAYS days removed." >> $LOGFILE

# ==== Optional: Transfer to remote backup server ====
# rsync -avz $BACKUP_FILE $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR >> $LOGFILE 2>&1

echo "Backup finished at $(date)" >> $LOGFILE
echo "========================================" >> $LOGFILE
echo "" >> $LOGFILE
