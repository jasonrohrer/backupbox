#!/bin/bash

echo "running" > /tmp/userCronJobRunning.txt


cd ~/backups
date=`date +"%Y_%b_%d_%a"`

mkdir $date

cd $date


~/myBackupOps.sh


rm /tmp/userCronJobRunning.txt
