#!/bin/bash

#Updating kali with fast mirrors
dpkg --add-architecture amd64
sudo apt-get -y update

#Installing required packages
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt-get install -y nmap terminator git virtualbox-qt swig snapd libcurl4-openssl-dev htop awscli libssl-dev jq ruby-full libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev build-essential libssl-dev libffi-dev python-dev python-setuptools libldns-dev python3-pip rename dstat silversearcher-ag gcc vim ctags tmux dtach
sudo systemctl enable docker
sudo apt-get install -y gimp cmake mplayer sshpass libcompress-raw-lzma-perl dos2unix tcpflow scapy fcrackzip unrar steghide ffmpeg binwalk tesseract-ocr sqlite nikto zbar-tools qrencode pdfcrack vagrant hexedit foremost bsdgamestaskwarrior guake openvpn nmap curl exiftool python-pil sqlitebrowser wireshark idle xclip flask flask-login colorama

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

echo "Removing boilerplate home directories"
rm -rf ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

#Configuring the distro with my hotkeys and configuration files
echo "Configuring the system with my hotkeys and keybindings"
sudo rm ~/.ackrc
sudo mv ~/dotfiles/.ackrc ~/.ackrc

sudo rm ~/.curlrc
sudo mv ~/dotfiles/.curlrc ~/.curlrc 

sudo rm ~/.gitconfig
sudo mv ~/dotfiles/.gitconfig ~/.gitconfig

sudo rm ~/.inputrc
sudo mv ~/dotfiles/.inputrc ~/.inputrc

sudo rm ~/.xinitrc
sudo mv ~/dotfiles/.xinitrc ~/.xinitrc

sudo rm ~/.vimrc
sudo mv ~/dotfiles/.vimrc ~/.vimrc
echo "Done"

#Making Vim look good
sudo mv ~/dotfiles/vim/ ~/.vim/
mkdir -p ~/.vim/bundle                                                      
cd ~/.vim/bundle                                                           
git clone git://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

#Moving goodbye.sh, run goodbye from terminal and this script will stop all penteterlab's docker instances and shutdown the computer.
sudo mv ~/dotfiles/goodbye.sh ~/

#Moving my scripts from repo to system
sudo mv ~/dotfiles/docker.sh ~/tools/
sudo mv ~/dotfiles/.bash_funcs ~/
sudo mv ~/dotfiles/.bash_aliases ~/

#Moving my .bashrc file
sudo mv ~/dotfiles/.bashrc ~/.bashrc

echo "Configuring pwnbox"
cd ~
git clone https://github.com/theGuildHall/pwnbox.git
cd ~/pwnbox
sudo cp *.sh /opt && sudo cp -R bloodhound/ /opt && sudo cp -R htb/ /opt && sudo cp -R icons/ /opt && sudo cp banner /opt

read -p "Enter your ovpn file's full location: (Use pwd) (Ex - /home/user/downloads - Use this format exactly) " ovpndir
ovpn=$(ls $opendir | sed -ne 's/\([0-9]*\).ovpn/\1/p')
sudo cp $ovpndir/$ovpn.ovpn /etc/openvpn/
sudo mv /etc/openvpn/$ovpn.ovpn /etc/openvpn/ovpn.conf

source ~/.bashrc

echo "Update and upgrade your kali machine anytime by typing \"updater\" in terminal!"
