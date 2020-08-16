#!/bin/bash

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

#fixing linux firmware
cd ~
git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
sudo cp -r linux-firmware/rtl_nic/ /lib/firmware/
sudo cp -r linux-firmware/i915/ /lib/firmware/
rm -rf ~/linux-firmware/
sudo update-initramfs -u

#install go
source ~/.bashrc
sudo rm -rf /usr/local/go
echo "Installing Golang"
wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
sudo tar -xvf go1.13.5.linux-amd64.tar.gz
sudo mv go /usr/local
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go'	>> ~/.bashrc			
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc	
source ~/.bashrc

#Installing some tools with the help of go
echo "installing goimports"
go get golang.org/x/tools/cmd/goimports

echo"installing gocode"
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

#Removing useless go installer
rm go1.13.5.linux-amd64.tar.gz

#Creating a tools folder in ~/, all tools will be available here
sudo rm -rf ~/tools/
mkdir ~/tools
cd ~/tools/

#Moving locky.py, use locky in terminal to generate some strong passwords
sudo mv ~/dotfiles/locky.py ~/tools/

#Installing tools in ~/tools/
cd ~/tools/
echo"installing pentestlab"
git clone https://github.com/eystsen/pentestlab.git

cd ~/tools/
echo "installing Decodify"
git clone https://github.com/s0md3v/Decodify.git
cd ./Decodify
make install
cd ~/tools/
echo "done, run dcode on your terminal to decode any text"

#install chromium
echo "Installing Chromium"
systemctl start snapd.service
sudo snap install chromium
echo "done"

echo "Installing Spotify..."
sudo snap install spotify
echo "done"

echo "installing JSParser"
git clone https://github.com/nahamsec/jsparser.git
cd jsparser*
pip install -r requirements.txt
sudo python setup.py install
cd ~/tools/
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

echo "downloading Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd SecLists*
cd ~/tools/SecLists/Discovery/DNS/

#THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo "done"

echo "downloading privilege-escalation-awesome-scripts-suite"
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git

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

echo "Configuring pwnbox"
mkdir ~/gitclones && cd ~/gitclones
git clone https://github.com/theGuildHall/pwnbox.git
cd ~/gitclones/pwnbox
sudo cp *.sh /opt && sudo cp -R bloodhound/ /opt && sudo cp -R htb/ /opt && sudo cp -R icons/ /opt && sudo cp banner /opt

read -p "Enter your ovpn file's full location: (Use pwd) (Ex - /home/user/downloads Use this format exactly) " ovpndir
ovpn=$(ls $opendir | sed -ne 's/\([0-9]*\).ovpn/\1/p')
sudo cp $ovpndir/$ovpn.ovpn /etc/openvpn/
sudo mv /etc/openvpn/$ovpn.ovpn /etc/openvpn/ovpn.conf
source ~/.bashrc



echo -e "Done! All tools are set up in ~/tools"
echo "Don't forget to set up AWS credentials in ~/.aws/ or type aws configure!"
echo "Get your free AWS account from here https://aws.amazon.com/s/dm/optimization/server-side-test/free-tier/free_np/"
echo "Get your AWS credentials here https://console.aws.amazon.com/iam/home?#/security_credential\n\n"
echo "Update and upgrade your kali machine anytime by typing updater in terminal!"

