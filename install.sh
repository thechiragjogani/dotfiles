#!/bin/bash

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

#Moving my scripts from repo to system
sudo mv ~/dotfiles/.bash_funcs ~/
sudo mv ~/dotfiles/.bash_aliases ~/

#Moving my .bashrc file
sudo mv ~/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
source ~/.bash_aliases
source ~/.bash_funcs

dpkg --add-architecture amd64
updater

echo "Configuring pwnbox"
cd ~
git clone https://github.com/theGuildHall/pwnbox.git
cd ~/pwnbox
sudo cp *.sh /pt && sudo cp -R bloodhound/ /opt && sudo cp -R htb/ /opt && sudo cp -R icons/ /opt && sudo cp banner /opt
rm -rf ~/pwnbox
sudo sh ~/dotfiles.tools.sh


read -p "Enter your ovpn file's full location: (Use pwd) (Ex - /home/user/downloads - Use this format exactly) " ovpndir; ovpn=$(ls $opendir | sed -ne 's/\([0-9]*\).ovpn/\1/p'); sudo cp $ovpndir/$ovpn.ovpn /etc/openvpn/; sudo mv /etc/openvpn/$ovpn.ovpn /etc/openvpn/ovpn.conf

source ~/.bashrc
echo "Update and upgrade your kali machine anytime by typing \"updater\" in terminal!"
