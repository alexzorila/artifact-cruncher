#!/bin/bash

# Elevate session
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Install dependencies
echo -e "\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing dependencies."
apt update -y
apt install dotnet6 unzip sleuthkit -y

# Install MFTECmd
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing MFTECmd."
git clone https://github.com/EricZimmerman/MFTECmd.git /opt/MFTECmd
dotnet publish /opt/MFTECmd/ -r ubuntu.22.04-x64 --self-contained --framework net6.0
cp -f -s /opt/MFTECmd/MFTECmd/bin/Debug/net6.0/ubuntu.22.04-x64/MFTECmd /usr/local/bin/

# Install Docker if missing
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing Docker."
docker > /dev/null 2>&1 || curl -fsSL https://get.docker.com | sh

# Install Plaso
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing Plaso."
docker pull log2timeline/plaso

# Install parsing script
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing Parsing Script."
mkdir /opt/parse
chmod +x ./parse.sh
cp -f ./parse.sh /opt/parse/parse
cp -f -s /opt/parse/parse /usr/local/bin/

# Cleanup
rm -rf get-docker.sh
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Setup completed.\n"
