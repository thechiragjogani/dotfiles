#!/usr/bin/zsh
source ~/.zshrc

rem ntp
sudo timedatectl set-timezone "Asia/Kolkata"
sudo timedatectl set-ntp "True"
ins systemd-timesyncd
sudo systemctl enable systemd-timesyncd

echo "Installing tools!"
#Installing required packages
cat /opt/packages.txt | xargs -I {} /usr/bin/zsh -c 'ins {} 2> /dev/null'

sudo systemctl start docker && sudo systemctl enable docker
sudo update-initramfs -u
cat /opt/labs.txt | xargs -I {} /usr/bin/zsh -c 'sudo docker pull {} 2> /dev/null'

wget "https://raw.githubusercontent.com/s0md3v/Locky/master/locky.py" -O /opt/tools/locky.py

#install go
sudo rm -rf /usr/local/go
echo "Installing Golang and tools!"
cd /tmp/; wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && ex go1.13.5.linux-amd64.tar.gz
sudo mv go /usr/local

echo "installing goimports" #import headers
go install golang.org/x/tools/cmd/goimports

echo "installing gocode" #autocomplete go code
go install github.com/nsf/gocode

echo "installing gobuster" #scanning hosts
go install github.com/OJ/gobuster

echo "Installing Aquatone" #mass subdomains enumeration
go install github.com/michenriksen/aquatone

echo "installing httprobe" #check if host has http or https
go install -u github.com/tomnomnom/httprobe
echo "done"

echo "installing unfurl"
go install -u github.com/tomnomnom/unfurl
echo "done"

echo "installing waybackurls" #archived webpages
go install github.com/tomnomnom/waybackurls
echo "done"

echo "installing FFUF" #Fuzzing
go install github.com/ffuf/ffuf
echo "done"

#Creating a tools folder in /opt, all tools will be available here
mkdir /opt/tools/

echo "installing pentestlab"
cd /opt/tools/
git clone https://github.com/eystsen/pentestlab.git

echo "installing Decodify"
cd /opt/tools/
git clone https://github.com/s0md3v/decodify
cd decodify
make install
echo "done, run dcode on your terminal to decode any text"

echo "installing JSParser"
cd /opt/tools/
git clone https://github.com/nahamsec/jsparser
cd jsparser
pip install -r requirements.txt
sudo python2 setup.py install
echo "done"

echo "installing LinEnum"
cd /opt/tools/
git clone https://github.com/rebootuser/linenum.git
cd linenum
mv LinEnum.sh linenum.sh
chmod +x linenum.sh
echo "done"

echo "installing linuxprivchecker"
cd /opt/tools/
git clone https://github.com/sleventyeleven/linuxprivchecker
cd ./linuxprivchecker
python3 setup.py install
echo "done"

echo "installing Sublist3r"
cd /opt/tools/
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
pip install -r requirements.txt
sudo python2 setup.py install
sudo python3 setup.py install
echo "done"

echo "installing teh_s3_bucketeers"
cd /opt/tools/
git clone https://github.com/tomdev/teh_s3_bucketeers.git
echo "done"

echo "installing lazys3"
cd /opt/tools/
git clone https://github.com/nahamsec/lazys3.git
echo "done"

echo "installing virtual host discovery"
cd /opt/tools/
git clone https://github.com/jobertabma/virtual-host-discovery.git
echo "done"

echo "installing knock"
cd /opt/tools/
git clone https://github.com/guelfoweb/knock.git
cd knock
pip install -r requirements.txt
sudo python2 setup.py install
echo "done"

echo "installing lazyrecon"
cd /opt/tools/
git clone https://github.com/nahamsec/lazyrecon.git
echo "done"

echo "installing massdns"
cd /opt/tools/
git clone https://github.com/blechschmidt/massdns.git
cd ./massdns
make
make install
echo "done"

echo "installing asnlookup" #Find IPv4 and IPv6 address owned by an organization
cd /opt/tools/
git clone https://github.com/yassineaboukir/asnlookup.git
cd ./asnlookup
pip install -r requirements.txt
pip3 install -r requirements.txt
echo "done"

echo "installing crtndstry"
cd /opt/tools/
git clone https://github.com/nahamsec/crtndstry.git
echo "done"

#THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cd /usr/share/seclists/Discovery/DNS/
cat dns-Jhaddix.txt | head -n -14 | sudo tee clean-jhaddix-dns.txt &> /dev/null
echo "done"

echo "downloading privilege-escalation-awesome-scripts-suite"
cd /opt/tools/
git clone https://github.com/carlospolop/PEASS-ng
echo "done"

echo "downloading LinEnum"
cd /opt/tools/
git clone https://github.com/rebootuser/linenum.git

echo "installing Hash-Buster"
cd /opt/tools/
git clone https://github.com/s0md3v/Hash-Buster.git
cd Hash-Buster
make
make install
echo "done"

echo "installing XSStrike"
cd /opt/tools/
git clone https://github.com/s0md3v/XSStrike
cd XSStrike
pip install -r requirements.txt
pip3 install -r requirements.txt

echo "Downloading stegsolve.jar"
cd /opt/tools/
wget "http://www.caesum.com/handbook/Stegsolve.jar" -O "stegsolve.jar"
chmod +x "stegsolve.jar"

echo "Downloading linux-exploit-suggester"
cd /opt/tools/
wget "https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh" -O les.sh
chmod +x "les.sh"

echo "Downloading cupp"
cd /opt/tools/
git clone https://github.com/Mebus/cupp.git

echo "Downloading poor-mans-pentest scripts"
cd /opt/tools/
git clone https://github.com/JohnHammond/poor-mans-pentest
cd poor-mans-pentest
sudo mkdir /opt/pmp/
sudo mv ./* /opt/pmp/
sudo rm -rf /opt/tools/poor-mans-pentest
echo "done"

echo "Done! All tools are set up in /opt/tools"
echo "Set up AWS credentials - aws configure"
echo "Free AWS account - https://aws.amazon.com/s/dm/optimization/server-side-test/free-tier/free_np/"
echo "AWS credentials - https://console.aws.amazon.com/iam/home?#/security_credential\n"
