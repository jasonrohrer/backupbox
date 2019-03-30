#!/bin/bash


thisDate=`date`

echo "rootCronJobB starting at $thisDate"


while [ -f /tmp/suCronJobRunning.txt ]
do
    sleep 10
done


thisDate=`date`

echo "rootCronJobB almost done at $thisDate"


sudo rtcwake -m off -l -t $(date +%s -d 'tomorrow 03:55')
