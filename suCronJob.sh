#!/bin/bash

echo "running" > /tmp/suCronJobRunning.txt

cd ~/backups

date=`date +"%Y_%m%b_%d_%a"`

mkdir $date

rsync -av --delete /home/backupuser/backups/$date/* $date/

backupSize=`du -sb $date | sed -e 's/\t.*//'| numfmt --to=iec-i | sed -e 's/\([0-9.]*\)/\1 /'`

backupCount=`ls -1 $date | wc -l`

remainSize=`df / | grep "/" | awk '{print $4}'`

remainSize=$[remainSize * 1024]

remainSize=`echo -n $remainSize | numfmt --to=iec-i | sed -e 's/\([0-9.]*\)/\1 /'`


reportDate=`date | fmt -w 24`

echo -e "\
$reportDate\n\
Backup folder:\n     $date\nsafely archived.\n\
${backupCount} files.\n\
${backupSize}B in this backup.\n\
${remainSize}B left on disk.\n\n" | lpr -P epson


rm /tmp/suCronJobRunning.txt
