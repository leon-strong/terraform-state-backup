#!/bin/bash -x
BACKUP_DIR=$HOME/etcd-backups
mkdir -p $BACKUP_DIR

timestamp=$(date +%s)


etcdctl snapshot save $BACKUP_DIR/terraform-states.$timestamp.tgz

BACKUP_FILE=`find $BACKUP_DIR -type f -mtime -1| tail -1`
if [ -e $BACKUP_FILE ]; then
  if [ -s $BACKUP_FILE ]; then
    echo "Backup was successful"
  else
    echo "Backup file had zero size"
  fi
else
  echo "Nope"
fi

# Remove files older than 30 days
echo "Removing old files"
find $BACKUP_DIR -name 'terraform-states*' -type f -mtime +30 -exec rm -v {} \;
