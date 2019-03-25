# put your own custom backup pull operations here
# this will be called from inside a date-stamped backup directory
# so you can create sub directories here, and do whatever you want
# but don't cd to absolute paths, or "cd .."

# make sure this file is installed in backupuser's home folder
# (the setup script will do this automatically)


# delete this warning after you add your own backup operations here

echo ""
echo ""
echo "Warning:  No user-supplied backup operations to perform."
echo ""
echo ""

#exit 1

latestList=`ssh backup.onehouronelife.com "cd backups; find . -name '*.gz' -mtime -1" | sed -e "s/\./backups"`


while read -r line; do
    scp backup.onehouronelife.com:$line .
done <<< "$latestList"



