#!/bin/bash
cd /home/ardupilot_user/ardupilot

echo ">>> Running ArduPilot prerequisite installer..."
/bin/bash /home/ardupilot_user/ardupilot/Tools/environment_install/install-prereqs-ubuntu.sh -y || { echo "install-prereqs-ubuntu.sh failed"; exit 1; }

# Fix: Explicitly specify the username for usermod
echo ">>> Adding user to dialout group..."
sudo usermod -a -G dialout ardupilot_user || { echo "Failed to add user to dialout group"; exit 1; }

echo ">>> Sourcing profile..."
. ~/.profile

echo ">>> Installing Python..."
sudo apt-get update
sudo apt-get install -y python3.10 || { echo "Failed to install Python"; exit 1; }
sudo ln -s /usr/bin/python3 /usr/bin/python || { echo "Failed to create symbolic link for python"; exit 1; }

# python -m pip install empy || { echo "Failed to install empy"; exit 1; }

echo ">>> Configuring ArduPilot SITL..."
cd /home/ardupilot_user/ardupilot

sudo dos2unix waf || { echo "Failed to convert line endings of waf"; exit 1; }

sudo chmod +x waf || { echo "Failed to change permissions of waf"; exit 1; }

sudo ./waf configure --board sitl || { echo "Waf configure failed"; exit 1; }

echo ">>> Compiling ArduPilot..."
sudo ./waf copter || { echo "ArduPilot build failed"; exit 1; }

echo ">>> ArduPilot installation completed successfully!"