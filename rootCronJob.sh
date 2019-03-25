#!/bin/bash

while [ -f /tmp/userCronJobRunning.txt ]
do
    sleep 10
done

sudo rtcwake -m off -l -t $(date +%s -d 'today 9:50')
