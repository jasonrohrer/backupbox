#!/bin/bash

cd ~/backups
date=`date +"%Y_%b_%d_%a"

mkdir $date

cd $date


~/myBackupOps.sh
