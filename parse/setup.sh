#!/bin/bash

# Elevate session
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Install dependencies
echo -e "\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing dependencies."
apt update -y
apt install unzip sleuthkit curl -y

# Install .NET SDK 9.0
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 9.0
export PATH="$PATH:$HOME/.dotnet" && source ~/.bashrc

# Install MFTECmd
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing MFTECmd."
git clone https://github.com/EricZimmerman/MFTECmd.git /opt/MFTECmd
dotnet publish /opt/MFTECmd/ --framework net9.0 --os linux --self-contained
cp -fs /opt/MFTECmd/MFTECmd/bin/Release/net9.0/linux-x64/publish/MFTECmd /usr/local/bin/

# Install Docker if missing
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing Docker."
docker > /dev/null 2>&1 || curl -fsSL https://get.docker.com | sh
service docker start

# Install Plaso
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing Plaso."
docker pull log2timeline/plaso:20240826

# Install parsing script
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Installing Parsing Script."
mkdir /opt/parse
chmod +x ./parse.sh
cp -f ./parse.sh /opt/parse/parse
cp -fs /opt/parse/parse /usr/local/bin/

# Cleanup
rm -rf get-docker.sh
echo -e "\n\n[$(date '+%d/%m/%Y %H:%M:%S')]: Parser setup done!\n"
