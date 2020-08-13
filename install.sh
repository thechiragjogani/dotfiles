#!/bin/bash

#Updating kali with fast mirrors
sudo rm /etc/apt/sources.list
sudo mv ~/dotfiles/sources.list /etc/apt/
sudo cp ~/dotfiles/alias-list.txt ~/
sudo apt-get -y update

#Installing required packages
sudo apt-get install -y nmap terminator git docker.io virtualbox-qt swig snapd libcurl4-openssl-dev htop awscli libssl-dev jq ruby-full libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev build-essential libssl-dev libffi-dev python-dev python-setuptools libldns-dev python3-pip rename dstat silversearcher-ag gcc vim ctags tmux dtach
sudo systemctl enable docker
sudo apt-get install -y gimp cmake mplayer sshpass libcompress-raw-lzma-perl dos2unix tcpflow scapy  fcrackzip unrar steghide ffmpeg binwalk tesseract-ocr sqlite nikto zbar-tools qrencode pdfcrack vagrant hexedit foremost bsdgamestaskwarrior guake openvpn nmap curl pinta exiftool python-pil sqlitebrowser wireshark idle xclip flask flask-login colorama

#Installing pip and dependencies
echo "installing pip"
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip install -U pip
pip install mako netifaces iptools pyopenssl pydispatch passlib dnspython XlsxWriter requests pwntools argparse
echo "done"

#Installing SimpleScreenRecorder
echo "Installing SimpleScreenRecorder"
echo "" | sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder
sudo apt-get install -y simplescreenrecorder

echo "Installing Sublime Text" 
#According to https://www.sublimetext.com/docs/3/linux_repositories.html, Installing Sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install -y apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text

echo "Install Real VNC Viewer..."
wget "https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.17.1113-Linux-x64.deb" -O vnc_viewer.deb
dpkg -i vnc_viewer.deb
rm vnc_viewer.deb

echo "Install Real VNC Connect (Server)..."
wget 'https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.2.1-Linux-x64.deb' -O vnc_server.deb
dpkg -i vnc_server.deb
rm vnc_server.deb

echo "Adding VNC Connect (Server) service to the default startup /etc/rc.local..."
grep "vncserver-x11-serviced.service" /etc/rc.local
if [ $? -eq 1 ]
then
	echo "systemctl start vncserver-x11-serviced.service" >> ~/etc/rc.local
fi

echo "Installing Atom..."
wget "https://atom.io/download/deb" -O atom.deb
dpkg -i atom.deb
rm atom.deb

echo "Installing Hopper..."
wget "https://d2ap6ypl1xbe4k.cloudfront.net/Hopper-v4-4.3.14-Linux.deb"
dpkg -i Hopper-v4-4.3.14-Linux.deb
rm Hopper-v4-4.3.14-Linux.deb


echo "Installing Oracle Java 8..."
echo "" | sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer

echo "Removing boilerplate home directories"
rmdir ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

echo "Setting terminator as the default terminal emulator"
sed -i s/Exec=gnome-terminal/Exec=terminator/g /usr/share/applications/gnome-terminal.desktop

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
touch ~/.bash_aliases
sudo cat ~/dotfiles/.bash_aliases >> ~/.bash_aliases
rm -rf ~/dotfiles/.bash_aliases

#Moving my .bashrc file
sudo rm -rf ~/.bashrc
sudo mv ~/dotfiles/bashrc ~/.bashrc

#Making the changes permanent
echo "source ~/.bash_funcs" >> ~/.bashrc
echo "source ~/.bash_aliases" >> ~/.bashrc

source ~/.bashrc

echo "Update and upgrade your kali machine anytime by typing \"updater\" in terminal!"