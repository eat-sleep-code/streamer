# This script will install streamer and any required prerequisites.
cd ~
echo -e ''
echo -e '\033[32mStreamer [Installation Script] \033[0m'
echo -e '\033[32m-------------------------------------------------------------------------- \033[0m'
echo -e ''
echo -e '\033[93mUpdating package repositories... \033[0m'
sudo apt update

echo ''
echo -e '\033[93mInstalling prerequisites... \033[0m'
sudo apt install -y git python3 python3-pip screen
sudo pip3 install keyboard 

echo '\033[93mProvisioning logs... \033[0m'
sudo mkdir -p /home/pi/logs
sudo chmod +rw /home/pi/logs
sudo sed -i '\|^tmpfs /home/pi/logs|d' /etc/fstab
sudo sed -i '$ a tmpfs /home/pi/logs tmpfs defaults,noatime,nosuid,size=16m 0 0' /etc/fstab
sudo mount -a

echo ''
echo -e '\033[93mInstalling Streamer... \033[0m'
cd ~
sudo rm -Rf ~/streamer
sudo git clone https://github.com/eat-sleep-code/streamer
sudo chown -R $USER:$USER streamer
cd streamer
sudo chmod +x streamer.py

echo ''
echo -e '\033[93mCreating Service... \033[0m'
sudo mv streamer.service /etc/systemd/system/streamer.service
sudo chown root:root /etc/systemd/system/streamer.service
sudo chmod +x *.sh 
echo 'Please see the README file for more information on configuring the service.'

cd ~
echo ''
echo -e '\033[93mSetting up aliases... \033[0m'
sudo touch ~/.bash_aliases
sudo sed -i '/\b\(function streamer\)\b/d' ~/.bash_aliases
sudo sed -i '$ a function streamer { sudo python3 ~/streamer/streamer.py "$@"; }' ~/.bash_aliases
echo -e 'You may use \e[1mstreamer <options>\e[0m to launch the program.'
echo ''
echo ''
echo -e '\033[32m-------------------------------------------------------------------------- \033[0m'
echo -e '\033[32mInstallation completed. \033[0m'
echo ''
sudo rm install-streamer.sh
bash
