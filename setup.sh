#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "Must run as root (or sudo)"
    exit 1
fi


# install packages
apt install git emacs

# for beep package
modprobe snd-pcsp
apt install beep



backupName="backupuser"




echo ""
echo ""
echo "Setting up new user account '$backupName'"
echo ""
echo ""

useradd -m -s /bin/bash $backupName

echo "Setting password for new user '$backupName': "

passwd $backupName


# Now execute other operations as $backupName

su $backupName<<EOSU

cd ~

mkdir backups

mkdir checkout
cd checkout

git clone https://github.com/jasonrohrer/backupbox.git

cd backupbox

cp myBackupOps.sh ~

cd ~

mkdir .ssh
scp jcr15@onehouronelife.com:.ssh/remoteServers_id_rsa .ssh/

echo -e "\
Host  backup.onehouronelife.com\n\
HostName   backup.onehouronelife.com\n\
IdentityFile ~/.ssh/remoteServers_id_rsa\n\
User    jcr13\n" >> .ssh/config

ssh backup.onehouronelife.com "echo 'Connection tested'"


cd ~/checkout/backupbox

crontab userCrontab


EOSU


echo "Enter username of 'safe' account"
echo -n "This is the sudoer account that already exists: "

read mainUser


su $mainUser<<EOSU2

cd ~
mkdir backups

mkdir tempSetupCheckout

cd tempSetupCheckout

git clone https://github.com/jasonrohrer/backupbox.git

cd backupbox
crontab -l
crontab suCrontab
crontab -l

cd ~
rm -r tempSetupCheckout

EOSU2



cd ~

mkdir tempSetupCheckout

cd tempSetupCheckout

git clone https://github.com/jasonrohrer/backupbox.git

cd backupbox
crontab -l
crontab rootCrontab
crontab -l

cd ~
rm -r tempSetupCheckout



echo ""
echo ""
echo "Be sure that backupbox is checked out in /home/$mainUser/checkout/backupbox"
echo ""
echo ""


echo ""
echo ""
echo "Be sure to add custom backup operations to /home/$backupName/myBackupOps.sh"
echo ""
echo ""

echo ""
echo ""
echo "Be sure to add a printer called 'epson' for lpr"
echo ""
echo ""

echo ""
echo -n "Hit ENTER when you're ready to set wakeup time and shut down:"

read userInput


sudo rtcwake -m off -l -t $(date +%s -d 'tomorrow 01:50')
