#!/bin/bash

thisDate=`date`

echo "rootCronJob starting at $thisDate"



while [ -f /tmp/userCronJobRunning.txt ]
do
    sleep 10
done


thisDate=`date`

echo "rootCronJob almost done at $thisDate"



sudo rtcwake -m off -l -t $(date +%s -d 'today 9:55')
