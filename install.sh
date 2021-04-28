#!/bin/bash
echo "Fixing GPG key errors if there are any!"
rm -rf /var/lib/apt/lists
apt-get update -y
apt-get install kali-archive-keyring git -y
apt-key adv --keyserver hkp://keys.gnupg.net --recv-keys 7D8D0BF6
gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6
gpg --keyserver hkp://keys.gnupg.net --recv-key 7D8D0BF6
gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -

echo "Configuring pwnbox"
cd ~
git clone https://github.com/theGuildHall/pwnbox.git
cd ~/pwnbox
sudo cp *.sh /opt && sudo cp -R bloodhound/ /opt && sudo cp -R htb/ /opt && sudo cp -R icons/ /opt && sudo cp banner /opt
rm -rf ~/pwnbox
source ~/.bashrc

echo "Removing boilerplate home directories"
rm -rf ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Templates ~/Videos
mkdir ~/htb
mkdir ~/thm
mkdir ~/ctf
touch /etc/kali-motd/disable-all

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

sudo rm ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
sudo mv ~/dotfiles/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/
echo "Done"

#Making Vim look good
sudo mv ~/dotfiles/vim/ ~/.vim/
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone git://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

#Moving my scripts from repo to system
sudo mv ~/dotfiles/.bash_funcs ~/
sudo mv ~/dotfiles/.bash_aliases ~/

#Moving my .bashrc file
sudo mv ~/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
source ~/.bash_aliases
source ~/.bash_funcs

dpkg --add-architecture amd64
cd ~
wget "https://github.com/IceM4nn/mirrorscript-v2/blob/master/mirrorscript-v2.py" -O sources.py
python3 sources.py

#Installing snap store and whatsapp
sudo apt update -y
sudo apt install snapd vlc
echo 'export PATH=$PATH:/snap/bin' >> ~/.bashrc
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/*
sudo systemctl start snapd.service
sudo systemctl enable snapd.service
sed -i 's/geteuid/getppid/' /usr/bin/vlc
sudo snap install core
sudo snap install whatsapp-for-linux
sudo ln -s /var/lib/snapd/desktop/applications/ /usr/share/applications/snap

#Installing flatpak and basic apps
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpack install flathub com.anydesk.Anydesk -y
flatpack install flathub com.github.joseexposito.touche -y
flatpack install flathub com.github.vladimiry.ElectronMail -y
flatpack install flathub io.github.liberodark.OpenDrive -y
flatpack install flathub org.libreoffice.LibreOffice -y
flatpack install flathub org.nmap.Zenmap -y
flatpack install flathub org.qbittorrent.qBittorrent -y
flatpack install flathub org.telegram.desktop -y
flatpack install flathub org.tordini.flavio.Minitube -y
flatpack install flathub us.zoom.Zoom -y

sudo sh ~/dotfiles/tools.sh
source ~/.bashrc

updater

read -p "Enter your ovpn file's full location: (Use pwd) (Ex - /home/user/downloads - Use this format exactly) " ovpndir; ovpn=$(ls $opendir | sed -ne 's/\([0-9]*\).ovpn/\1/p'); sudo cp $ovpndir/$ovpn.ovpn /etc/openvpn/; sudo mv /etc/openvpn/$ovpn.ovpn /etc/openvpn/ovpn.conf

source ~/.bashrc
echo "Update and upgrade your kali machine anytime by typing \"updater\" in terminal!"
