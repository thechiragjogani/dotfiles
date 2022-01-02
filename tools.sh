#!/usr/bin/zsh
source ~/.zshrc

rem ntp
sudo timedatectl set-timezone "Asia/Kolkata"
sudo timedatectl set-ntp "True"
ins systemd-timesyncd
sudo systemctl enable systemd-timesyncd

#Installing nodejs
curl -sL install-node.vercel.app/lts | sudo bash

echo "Installing tools!"
sudo systemctl start docker && sudo systemctl enable docker
sudo update-initramfs -u
cat /opt/labs.txt | xargs -I {} /usr/bin/zsh -c 'sudo docker pull {} 2> /dev/null'

wget "https://raw.githubusercontent.com/s0md3v/Locky/master/locky.py" -O /opt/tools/locky.py

#Creating a tools folder in /opt, all tools will be available here
mkdir /opt/tools/

#install go
sudo rm -rf /usr/local/go
echo "Installing Golang and tools!"
cd /tmp/; wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && ex go1.13.5.linux-amd64.tar.gz
sudo mv go /usr/local

echo "installing goimports" #import headers automatically for go code
echo "installing gocode" #autocomplete go code
echo "installing gobuster" #scanning hosts
echo "Installing Aquatone" #mass subdomains enumeration
echo "installing httprobe" #check if host has http or https
echo "installing unfurl"
echo "installing waybackurls" #archived webpages
echo "installing FFUF" #Fuzzing

cat /opt/gotools.txt | xargs -I {} /usr/bin/zsh -c 'go install {}'

echo "Downloading tools from git!"
cd /opt/tools/
cat /opt/gittools.txt | xargs -I {} /usr/bin/zsh -c 'git clone https://github.com/{}'
cd decodify
make install
cd jsparser
pip install -r requirements.txt
sudo python2 setup.py install
cd linenum
mv LinEnum.sh linenum.sh
chmod +x linenum.sh
cd linuxprivchecker
python3 setup.py install
cd Sublist3r
pip install -r requirements.txt
sudo python2 setup.py install
sudo python3 setup.py install
cd knock
pip install -r requirements.txt
sudo python2 setup.py install
cd massdns
make
make install
cd asnlookup
pip install -r requirements.txt
pip3 install -r requirements.txt
cd Hash-Buster
make
make install
cd XSStrike
pip install -r requirements.txt
pip3 install -r requirements.txt

echo "Downloading poor-mans-pentest scripts"
cd poor-mans-pentest
sudo mkdir /opt/pmp/
sudo mv ./* /opt/pmp/
sudo rm -rf /opt/tools/poor-mans-pentest
echo "done"

cd /opt/tools/
echo "Downloading stegsolve.jar"
wget "http://www.caesum.com/handbook/Stegsolve.jar" -O "stegsolve.jar"; chmod +x "stegsolve.jar"

echo "Downloading linux-exploit-suggester"
wget "https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh" -O les.sh; chmod +x "les.sh"

#THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cd /usr/share/seclists/Discovery/DNS/
cat dns-Jhaddix.txt | head -n -14 | sudo tee clean-jhaddix-dns.txt &> /dev/null

echo "Done! All tools are set up in /opt/tools"
echo "Set up AWS credentials - aws configure"
echo "Free AWS account - https://aws.amazon.com/s/dm/optimization/server-side-test/free-tier/free_np/"
echo "AWS credentials - https://console.aws.amazon.com/iam/home?#/security_credential\n"

cd