#!/usr/bin/env bash

set -e

set -x

sudo apt-get install autoconf automake libtool python3-venv python3-wheel wget -y

sudo wget https://github.com/mikefarah/yq/releases/download/3.4.1/yq_linux_amd64 -O /usr/bin/yq &&\
sudo chmod +x /usr/bin/yq


#ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
dpkg -i ripgrep_11.0.2_amd64.deb

#nodejs
curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install yarn without nodejs. The package being at the system-level means it
# will still be available if you switch node version.
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install --no-install-recommends -y yarn


#ctags
git clone https://github.com/universal-ctags/ctags.git ~/ctags
cd ~/ctags
./autogen.sh 
./configure
make
make install
cd -

rm -f ~/ctags



# Cleanup whats left...
sudo apt-get autoremove -y
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

