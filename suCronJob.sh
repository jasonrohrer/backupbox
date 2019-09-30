#!/bin/bash

thisDate=`date`

echo "suCronJob starting at $thisDate"


echo "running" > /tmp/suCronJobRunning.txt

cd ~/backups

date=`date +"%Y_%m%b_%d_%a"`

mkdir $date

rsync -av --delete /home/backupuser/backups/$date/* $date/


backupSizeB=`du -sb $date | sed -e 's/\t.*//'`


backupSize=`echo -n $backupSizeB | numfmt --to=iec-i | sed -e 's/\([0-9.]*\)/\1 /'`

backupCount=`ls -1 $date | wc -l`

remainSizeB=`df / | grep "/" | awk '{print $4}'`

remainSizeB=$[remainSizeB * 1024]

remainSize=`echo -n $remainSizeB | numfmt --to=iec-i | sed -e 's/\([0-9.]*\)/\1 /'`

daysLeft=$[ remainSizeB / ( backupSizeB * 2 ) ]

timeLeft="$daysLeft days";

if [ "$daysLeft" -gt "730" ]
then
	yearsLeft=$[ daysLeft / 365 ]
	timeLeft="$yearsLeft years";
elif [ "$daysLeft" -gt "60" ]
then
	monLeft=$[ daysLeft / 30 ]
	timeLeft="$monLeft months";
fi


reportDate=`date | fmt -w 24`

echo -e "\
$reportDate\n\
Backup folder:\n     $date\nsafely archived.\n\
${backupCount} files.\n\
${backupSize}B in this backup.\n\
${remainSize}B left on disk.\n\
${timeLeft} left\n\n" | lpr -P epson


# sleep here to make sure print job finishes before shutdown
# otherwise, a duplicate job might print at next startup,
# in the middle of the night
sleep 30

queueResult=`lpq -P epson | grep "no entries"`


if [[ $queueResult =~ "no entries" ]]
then
    echo "suCronJob print job completed"
else
    thisDate=`date`
    echo "suCronJob print job did NOT complete at $thisDate"
    echo "entering beeping loop"

    start_time=`date -u +%s`
    elapsed=0
    
    while ! [[ $queueResult =~ "no entries" ]] && [ $elapsed -lt 3600 ]
    do
	beep -l 1000
	sleep 30

	this_time=`date -u +%s`
	elapsed=$[ this_time - start_time ]

	queueResult=`lpq -P epson | grep "no entries"`
    done
    
    thisDate=`date`

    if [ $elapsed -ge 3600 ]
    then
       lprm -P epson -
       echo "suCronJob finally gave up and canceled print job at $thisDate"
    else
	echo "suCronJob print job finally went through at $thisDate"
    fi
fi


rm /tmp/suCronJobRunning.txt


thisDate=`date`

echo "suCronJob ending at $thisDate"
