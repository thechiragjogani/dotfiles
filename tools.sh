#!/usr/bin/zsh
source ~/.zshrc
ins docker*
rem ntp
sudo timedatectl set-timezone "Asia/Kolkata"
sudo timedatectl set-ntp "True"
ins systemd-timesyncd
sudo systemctl enable systemd-timesyncd
sudo timedatectl set-local-rtc 1


echo "Installing tools!"
sudo systemctl start docker && sudo systemctl enable docker
sudo update-initramfs -u
cat /opt/labs.txt | xargs -I {} /usr/bin/zsh -c 'sudo docker pull {} 2> /dev/null'

#install go
sudo apt install golang

echo "installing goimports" #import headers automatically for go code
echo "installing gocode" #autocomplete go code
echo "installing gobuster" #scanning hosts
echo "Installing Aquatone" #mass subdomains enumeration
echo "installing httprobe" #check if host has http or https
echo "installing unfurl"
echo "installing waybackurls" #archived webpages
echo "installing FFUF" #Fuzzing

cat /opt/gotools.txt | xargs -I {} /usr/bin/zsh -c 'sudo go install {} 2>/dev/null'

echo "Downloading tools from git!"
#Creating a tools folder in /opt, all tools will be available here
sudo mkdir /opt/tools/
cd /opt/tools/
sudo git clone https://github.com/tmiland/dpkg-zstd-patches.git
cd dpkg-zstd-patches
sudo dpkg -i ./deb-packages/dpkg_1.20.12_amd64.deb
sudo dpkg -i ./deb-packages/dpkg-repack_1.47_all.deb

cd /opt/tools/
sudo wget "https://raw.githubusercontent.com/s0md3v/Locky/master/locky.py" -O locky.py

sudo git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts
git config --global --add safe.directory /opt/tools/nerd-fonts
sudo git sparse-checkout add patched-fonts/FiraCode
./install.sh FiraCode

cat /opt/gittools.txt | xargs -I {} /usr/bin/zsh -c 'sudo git clone https://github.com/{}'
cd /opt/tools/decodify
sudo make install
cd /opt/tools/jsparser
sudo pip install -r requirements.txt
sudo python2 setup.py install
cd /opt/tools/linenum
sudo mv LinEnum.sh linenum.sh
sudo chmod +x linenum.sh
cd /opt/tools/linuxprivchecker
sudo python3 setup.py install
cd /opt/tools/Sublist3r
sudo pip install -r requirements.txt
sudo python2 setup.py install
sudo python3 setup.py install
cd /opt/tools/knock
sudo pip install -r requirements.txt
sudo python2 setup.py install
cd /opt/tools/massdns
sudo make install
cd /opt/tools/asnlookup
sudo pip install -r requirements.txt
sudo pip3 install -r requirements.txt
cd /opt/tools/Hash-Buster
sudo make install
cd /opt/tools/XSStrike
sudo pip install -r requirements.txt
sudo pip3 install -r requirements.txt

echo "Downloading poor-mans-pentest scripts"
cd /opt/tools/poor-mans-pentest
sudo mkdir /opt/pmp/
sudo mv ./* /opt/pmp/
sudo rm -rf /opt/tools/poor-mans-pentest
echo "done"

cd /opt/tools/
echo "Downloading stegsolve.jar"
sudo wget "http://www.caesum.com/handbook/Stegsolve.jar" -O "stegsolve.jar"; sudo chmod +x "stegsolve.jar"

echo "Downloading linux-exploit-suggester"
sudo wget "https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh" -O les.sh; sudo chmod +x "les.sh"

#THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cd /usr/share/seclists/Discovery/DNS/
sudo cat dns-Jhaddix.txt | head -n -14 | sudo tee clean-jhaddix-dns.txt &> /dev/null

echo "Done! All tools are set up in /opt/tools"
echo "Set up AWS credentials - aws configure"
echo "Free AWS account - https://aws.amazon.com/s/dm/optimization/server-side-test/free-tier/free_np/"
echo "AWS credentials - https://console.aws.amazon.com/iam/home?#/security_credential\n"
