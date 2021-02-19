#!/bin/bash

#Installing required packages
sudo apt-get install -y nmap terminator git virtualbox-qt swig snapd libcurl4-openssl-dev htop awscli libssl-dev jq ruby-full libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev build-essential libssl-dev libffi-dev python-dev python-setuptools libldns-dev python3-pip rename dstat silversearcher-ag gcc vim tmux dtach gimp cmake mplayer sshpass libcompress-raw-lzma-perl dos2unix tcpflow scapy fcrackzip unrar steghide ffmpeg binwalk tesseract-ocr sqlite nikto zbar-tools qrencode pdfcrack vagrant hexedit foremost guake openvpn nmap curl exiftool sqlitebrowser wireshark idle xclip xautomation docker-ce docker-ce-cli containerd.io docker.io docker apt-transport-https ca-certificates curl gnupg-agent software-properties-common

sudo systemctl enable docker

#Pulling docker images for web pentesting
sudo dockerd < /dev/null &> /dev/null &
docker pull raesene/bwapp
docker pull bkimminich/juice-shop
docker pull webgoat/webgoat-8.0
docker pull webgoat/webgoat-7.1
docker pull eystsen/vulnerablewordpress
docker pull vulnerables/web-dvwa
docker pull citizenstig/nowasp 
docker pull eystsen/altoro
docker pull opendns/security-ninjas

sudo update-initramfs -u


#Installing pip and dependencies
echo "installing pip"
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip install -U pip
pip install mako netifaces iptools pyopenssl pydispatch passlib dnspython XlsxWriter requests pwntools argparse
echo "done"

#Installing SimpleScreenRecorder
echo "Installing SimpleScreenRecorder"
sudo apt-get install software-properties-common
sudo apt update
sudo apt-get install -y simplescreenrecorder

#Installing VSCode
echo "installing VSCode"
cd ~
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"; mv download* code.deb
dpkg -i code.deb
rm -rf code.deb
echo "done"

echo "Installing Sublime Text" 
#According to https://www.sublimetext.com/docs/3/linux_repositories.html, Installing Sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install -y apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text

echo "Installing Hopper..."
wget "https://d2ap6ypl1xbe4k.cloudfront.net/Hopper-v4-4.5.29-Linux.deb"
dpkg -i Hopper-v4-4.5.29-Linux.deb
rm -rf Hopper-v4-4.5.29-Linux.deb

#install go
source ~/.bashrc
sudo rm -rf /usr/local/go
echo "Installing Golang"
wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
sudo tar -xvf go1.13.5.linux-amd64.tar.gz
sudo mv go /usr/local
sudo mkdir ~/gocode
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go'	>> ~/.bashrc
echo 'export GOPATH=$GOPATH:$HOME/gocode' >> ~/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin:$GOROOT/bin' >> ~/.bashrc	
source ~/.bashrc

#Installing some tools with the help of go
echo "installing goimports"
go get golang.org/x/tools/cmd/goimports

echo "installing gocode"
go get github.com/nsf/gocode

echo "installing gobuster"
go get github.com/OJ/gobuster

echo "Installing Aquatone"
go get github.com/michenriksen/aquatone

echo "installing httprobe"
go get -u github.com/tomnomnom/httprobe 
echo "done"

echo "installing unfurl"
go get -u github.com/tomnomnom/unfurl 
echo "done"

echo "installing waybackurls"
go get github.com/tomnomnom/waybackurls
echo "done"

echo "installing FFUF"
go get github.com/ffuf/ffuf
echo "done"

#Removing useless go installer
rm go1.13.5.linux-amd64.tar.gz

#Creating a tools folder in ~/, all tools will be available here
sudo rm -rf ~/tools/
mkdir ~/tools
cd ~/tools/
sudo mv ~/dotfiles/docker.sh ~/tools/

#Moving goodbye.sh, run goodbye from terminal and this script will stop all penteterlab's docker instances and shutdown the computer.
sudo mv ~/dotfiles/goodbye.sh ~/

#Moving locky.py, use locky in terminal to generate some strong passwords
sudo mv ~/dotfiles/locky.py ~/tools/

#Installing tools in ~/tools/
cd ~/tools/
echo "installing pentestlab"
git clone https://github.com/eystsen/pentestlab.git

cd ~/tools/
echo "installing Decodify"
git clone https://github.com/s0md3v/Decodify.git
cd ./Decodify
make install
cd ~/tools/
echo "done, run dcode on your terminal to decode any text"

echo "installing JSParser"
git clone https://github.com/nahamsec/jsparser.git
cd jsparser*
pip install -r requirements.txt
sudo python setup.py install
cd ~/tools/
echo "done"

echo "installing LinEnum"
git clone https://github.com/rebootuser/linenum.git
cd linenum
mv LinEnum.sh linenum.sh
chmod +x linenum.sh
cd ~/tools/
echo "done"

echo "installing linuxprivchecker"
git clone https://github.com/sleventyeleven/linuxprivchecker
echo "done"

echo "installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
pip install -r requirements.txt
sudo python setup.py install
cd ~/tools/
echo "done"


echo "installing teh_s3_bucketeers"
git clone https://github.com/tomdev/teh_s3_bucketeers.git
echo "done"


echo "installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git
echo "done"

echo "installing lazys3"
git clone https://github.com/nahamsec/lazys3.git
echo "done"

echo "installing virtual host discovery"
git clone https://github.com/jobertabma/virtual-host-discovery.git
echo "done"

echo "installing knock"
git clone https://github.com/guelfoweb/knock.git
cd knock
pip install -r requirements.txt 
sudo python setup.py install
cd ~/tools/
echo "done"

echo "installing lazyrecon"
git clone https://github.com/nahamsec/lazyrecon.git
cd ~/tools/
echo "done"

echo "installing massdns"
git clone https://github.com/blechschmidt/massdns.git
cd ~/tools/massdns
make
cd ~/tools/
echo "done"

echo "installing asnlookup"
#Asnlookup is used to find all IPv4 and IPv6 address owned by an Organization!
git clone https://github.com/yassineaboukir/asnlookup.git
cd ~/tools/asnlookup
pip install -r requirements.txt
cd ~/tools/
echo "done"

echo "installing crtndstry"
git clone https://github.com/nahamsec/crtndstry.git
echo "done"

#THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cd /usr/share/seclists/Discovery/DNS/
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo "done"

echo "downloading privilege-escalation-awesome-scripts-suite"
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git
mv privilege-escalation-awesome-scripts-suite peas
echo "done"

echo "downloading LinEnum"
git clone https://github.com/rebootuser/linenum.git

echo "installing Hash-Buster"
cd ~/tools/
git clone https://github.com/s0md3v/Hash-Buster.git
cd Hash-Buster
make install
echo "done"

echo "installing XSStrike"
cd ~/tools/
git clone https://github.com/s0md3v/XSStrike.git
cd XSStrike
pip install -r requirements.txt

echo "Downloading stegsolve.jar..."
cd ~/tools/
wget "http://www.caesum.com/handbook/Stegsolve.jar" -O "stegsolve.jar"
chmod +x "stegsolve.jar"

source ~/.bashrc


echo -e "Done! All tools are set up in ~/tools"
echo "Don't forget to set up AWS credentials in ~/.aws/ or type aws configure!"
echo "Get your free AWS account from here https://aws.amazon.com/s/dm/optimization/server-side-test/free-tier/free_np/"
echo "Get your AWS credentials here https://console.aws.amazon.com/iam/home?#/security_credential\n\n"
echo "Update and upgrade your kali machine anytime by typing updater in terminal!"

