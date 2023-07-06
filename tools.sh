#!/usr/bin/zsh
source ~/.zshrc
echo "Installing tools!"

ins docker*

rem ntp
sudo timedatectl set-timezone "Asia/Kolkata"
sudo timedatectl set-ntp "True"
ins systemd-timesyncd
sudo systemctl enable systemd-timesyncd
sudo timedatectl set-local-rtc 1

sudo systemctl start docker && sudo systemctl enable docker
sudo update-initramfs -u

#install go
ins golang

#Creating a tools folder in /opt, all tools will be available here
sudo chown -R kali:kali /opt
mkdir /opt/tools/
tools
wget "https://raw.githubusercontent.com/s0md3v/Locky/master/locky.py" -O locky.py

sudo git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts
git config --global --add safe.directory /opt/tools/nerd-fonts
sudo git sparse-checkout add patched-fonts/FiraCode
./install.sh FiraCode

cat /opt/gittools.txt | xargs -I {} /usr/bin/zsh -c 'cd /opt/tools/; sudo git clone https://github.com/{}'

cd /opt/tools/decodify
sudo make install
cd /opt/tools/Hash-Buster
sudo make install

cd /opt/tools/poor-mans-pentest
sudo mkdir /opt/pmp/
sudo mv ./* /opt/pmp/
sudo rm -rf /opt/tools/poor-mans-pentest

# cd /opt/tools/
# echo "Downloading stegsolve.jar"
# sudo wget "http://www.caesum.com/handbook/Stegsolve.jar" -O "stegsolve.jar"; sudo chmod +x "stegsolve.jar"

# echo "Downloading linux-exploit-suggester"
# sudo wget "https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh" -O les.sh; sudo chmod +x "les.sh"

# #THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
# cd /usr/share/seclists/Discovery/DNS/
# sudo cat dns-Jhaddix.txt | head -n -14 | sudo tee clean-jhaddix-dns.txt &> /dev/null

cat /opt/labs.txt | xargs -I {} /usr/bin/zsh -c 'sudo docker pull {} 2> /dev/null'
cat /opt/gotools.txt | xargs -I {} /usr/bin/zsh -c 'sudo go install {} 2>/dev/null'

echo "Done! All tools are set up in /opt/tools"
