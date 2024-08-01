#!/usr/bin/zsh
source $HOME/.zshrc
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

#Creating a tools folder in /opt, all tools will be available here
mkdir $HOME/Tools
tools
wget "https://raw.githubusercontent.com/s0md3v/Locky/master/locky.py" -O locky.py

cat /opt/gittools.txt | xargs -I {} /usr/bin/zsh -c 'cd $HOME/Tools; git clone https://github.com/{}'

cd $HOME/Tools/decodify
sudo make install
cd $HOME/Tools/Hash-Buster
sudo make install
cd $HOME/Tools/jwt_tool
pip3 install -r requirements.txt
chmod +x jwt_tool.py
sudo ln -s $HOME/Tools/jwt_tool/jwt_tool.py /usr/bin/jwt_tool

cd /usr/share/seclists/Discovery/DNS/
cat dns-Jhaddix.txt | head -n -14 | tee clean-jhaddix-dns.txt &> /dev/null

ins gobuster

tools
cd reconftw/
./install.sh

cat /opt/labs.txt | xargs -I {} /usr/bin/zsh -c 'sudo docker pull {} 2> /dev/null'

echo "Done! All tools are set up in $HOME/Tools"
