#!/bin/bash
# Federico Squartini
# Mongo Backup

# Storage folder where to move backup files
storage=/mongobackups
remoteIp=127.0.0.1 # Should have key based authentication enabled
mongoPass=xxxxxxxxx
remotestorage=root@$remoteIp:/mongobackups
# Destination file names
date_daily=`date +"%d-%m-%Y"`
backupfile=$date_daily.tar.gz
cd $storage
mongodump -u admin -p mongoPass  && \
    tar -czvf $backupfile dump && \
    rm -rf dump
#find $storage/ -maxdepth 1 -mtime +14 -type f -name "*.tar.gz" -exec rm -fv {} \;
find $storage/ -maxdepth 1 -mtime +14 -type f -name "*.tar.gz" -exec echo  {} \;
rsync -a --delete $storage/ $remotestorage
