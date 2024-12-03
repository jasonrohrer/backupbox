# delete old data, if it exists
thisYear=`date +"%Y"`

# go back two years, meaning we'll keep at least one full year of daily backups
# even if it's January 2nd today

oldYear=$((thisYear - 2))


# assume 2000 is a safe start year
# we weren't running backups before that.
curYear=2000

echo 
echo "DRY RUN"
echo "This will list all the files that will be deleted"

echo 
echo -n "Hit ENTER when ready:"

read

while [ $curYear -le $oldYear ]; do
  echo "WOULD delete daily backups for $curYear"

  find  -mindepth 1 -maxdepth 1 -name "${curYear}_*" \! -name "*_01_*"

  ((curYear++))

  echo 
  echo -n "Hit ENTER when ready:"
  
  read
done


echo "DRY RUN"
echo "This will list all the files from old years that will be kept"

echo 
echo -n "Hit ENTER when ready:"

read


curYear=2000

while [ $curYear -le $oldYear ]; do
  echo "WOULD keep daily backups for $curYear"

  find  -mindepth 1 -maxdepth 1 -name "${curYear}_*" -name "*_01_*"

  ((curYear++))

  echo 
  echo -n "Hit ENTER when ready:"
  
  read
done


echo 
echo 
echo "********"
echo
echo "REAL RUN"
echo "This will actually DELETE files."

echo 
echo -n "Type YES and press ENTER when ready:"

read confirm


while [ "$confirm" != "YES" ]; do
	echo 
	echo -n "Type YES and press ENTER when ready:"
	
	read confirm
done




echo 
echo "Running actual deletion now."




curYear=2000

while [ $curYear -le $oldYear ]; do
  echo "Actually DELETING daily backups for $curYear"

  find  -mindepth 1 -maxdepth 1 -name "${curYear}_*" \! -name "*_01_*" -exec rm -r {} +

  ((curYear++))

  echo 
  echo -n "Hit ENTER to continue:"
  
  read
done