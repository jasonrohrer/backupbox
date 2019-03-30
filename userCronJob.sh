#!/bin/bash

thisDate=`date`

echo "userCronJob starting at $thisDate"


echo "running" > /tmp/userCronJobRunning.txt


cd ~/backups
date=`date +"%Y_%m%b_%d_%a"`

mkdir $date

cd $date


~/myBackupOps.sh



rm /tmp/userCronJobRunning.txt

thisDate=`date`
echo "userCronJob finished at $thisDate"
