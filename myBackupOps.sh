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

latestList=`ssh backup.onehouronelife.com "cd backups; find . -name '*.gz' -mtime -1" | sed -e "s/\./backups/"`


while read -r line; do
    scp backup.onehouronelife.com:$line .
done <<< "$latestList"


git clone https://github.com/jasonrohrer/OneLife.git
git clone https://github.com/jasonrohrer/OneLifeData7.git
git clone https://github.com/jasonrohrer/OneLifeGraphicsMasters.git
git clone https://github.com/jasonrohrer/OneLifeMusicMaster.git
git clone https://github.com/jasonrohrer/OneLifeData7_trailer1.git
git clone https://github.com/jasonrohrer/minorGems.git
git clone https://github.com/jasonrohrer/jason-rohrer.git
git clone https://github.com/jasonrohrer/backupbox.git
git clone https://github.com/jasonrohrer/Primrose.git
git clone https://github.com/jasonrohrer/leadController.git
git clone https://github.com/jasonrohrer/wallClockProfiler.git
git clone https://github.com/jasonrohrer/tinySockets.git
git clone https://github.com/jasonrohrer/SleepIsDeath.git
git clone https://github.com/jasonrohrer/GameDesignSketchbook.git
git clone https://github.com/jasonrohrer/Between.git
git clone https://github.com/jasonrohrer/Gravitation.git
git clone https://github.com/jasonrohrer/Passage.git
git clone https://github.com/jasonrohrer/Cultivation.git
git clone https://github.com/jasonrohrer/Transcend.git
git clone https://github.com/jasonrohrer/ProjectNovemberGraphicsMasters.git
git clone https://github.com/jasonrohrer/tempProjects.git


# private repositories, need keys for git user specified in .ssh/config
git clone git@github.com:jasonrohrer/jason-rohrer-private.git
git clone git@github.com:jasonrohrer/ProjectSkydropGraphicsMasters.git
git clone git@github.com:jasonrohrer/ProjectNovember.git
git clone git@github.com:jasonrohrer/book0.git