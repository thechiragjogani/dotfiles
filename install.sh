#!/usr/bin/zsh
echo "Removing boilerplate home directories!"
sudo rm -rf $HOME/* $HOME/.vim; mkdir -p $HOME/ctf/htb $HOME/ctf/thm
sudo touch /etc/kali-motd/disable-all

#Updating sources with fast mirrors
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
echo "deb http://kali.download/kali kali-rolling main contrib non-free\ndeb-src http://kali.download/kali kali-rolling main contrib non-free\ndeb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free" | sudo tee /etc/apt/sources.list

echo "Fixing GPG key errors if there are any!"
sudo rm -rf /var/lib/apt/lists
sudo apt update 2>&1 1>/dev/null | sed -ne 's/.*NO_PUBKEY //p' | while read key; do if ! [[ ${keys[*]} =~ "$key" ]]; then sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys "$key"; keys+=("$key"); fi; done
sudo apt update -y; sudo apt install kali-archive-keyring git stow python3 -y

#Configuring hotkeys and configuration files
echo "Configuring my hotkeys and keybindings!"
cp -r configs/ $HOME; sudo cp ./*.txt /opt/; sudo cp tools.sh /tmp/; sudo chmod +x /tmp/tools.sh
cd $HOME/configs/; stow ack curl git input vim qterminal xinit zsh; source $HOME/.zshrc

# #Installing flatpak and apps
# sudo apt install flatpak gnome-software-plugin-flatpak -y
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpack install flathub com.anydesk.Anydesk org.qbittorrent.qBittorrent us.zoom.Zoom -y

/tmp/tools.sh
updater
clear
echo "Now you can update and upgrade your kali machine anytime by typing \"updater\" command!"
