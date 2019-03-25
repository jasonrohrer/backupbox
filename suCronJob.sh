#!/bin/bash

cd ~/backups

date=`date +"%Y_%b_%d_%a"

mkdir $date

rsync -av --delete /home/backupuser/backups/$date $date

backupSize=`du -sb $date | sed -e 's/\t.*//'| numfmt --to=iec-i | sed -e 's/\([0-9]*\)/\1 /'`

remainSize=`df / | grep "/" | awk '{print $4}'| numfmt --to=iec-i | sed -e 's/\([0-9]*\)/\1 /'`

echo -e "\
Backup folder $date safely archived.\n\
$backupSize B in this backup.\n
$remainSize B left on disk.\n\n" | lpr -P epson
