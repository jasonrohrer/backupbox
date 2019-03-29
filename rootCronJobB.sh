#!/bin/bash


while [ -f /tmp/suCronJobRunning.txt ]
do
    sleep 10
done


sudo rtcwake -m off -l -t $(date +%s -d 'tomorrow 03:55')
