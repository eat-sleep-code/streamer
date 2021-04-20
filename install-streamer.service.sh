# This script will install the service to start the Streamer when the Raspberry Pi is started.
cd ~
echo -e ''
echo -e '\033[32mStreamer Service [Installation Script] \033[0m'
echo -e '\033[32m-------------------------------------------------------------------------- \033[0m'
echo -e ''
echo -e '\033[93mEnabling Service... \033[0m'
sudo systemctl enable streamer.service

echo ''
echo -e '\033[93mStarting Service... \033[0m'
sudo systemctl start streamer.service

echo ''
echo -e '\033[32m-------------------------------------------------------------------------- \033[0m'
echo -e '\033[32mRebooting... \033[0m'
echo ''
sudo reboot
