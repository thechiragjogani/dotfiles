#!/usr/bin/zsh
echo "Removing boilerplate home directories!"
sudo rm -rf $HOME/.vim $HOME/Pictures $HOME/Documents $HOME/Music $HOME/Videos; mkdir -p $HOME/ctf/htb $HOME/ctf/thm

#Updating sources with fast mirrors
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add - 2> /dev/null

echo "deb https://mirrors.ocf.berkeley.edu/kali kali-rolling main contrib non-free\ndeb-src https://mirrors.ocf.berkeley.edu/kali kali-rolling main contrib non-free\ndeb https://mirrors.ocf.berkeley.edu/debian sid main contrib non-free\ndeb-src https://mirrors.ocf.berkeley.edu/debian sid main contrib non-free\ndeb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free" | sudo tee /etc/apt/sources.list

echo "Fixing GPG key errors if there are any!"
sudo rm -rf /var/lib/apt/lists
sudo apt update 2>&1 1>/dev/null | sed -ne 's/.*NO_PUBKEY //p' | while read key; do if ! [[ ${keys[*]} =~ "$key" ]]; then sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys "$key"; keys+=("$key"); fi; done
sudo apt update -y 2> /dev/null
sudo apt install kali-archive-keyring git stow python3 neovim curl nvim -y 2> /dev/null

#Configuring hotkeys and configuration files
echo "Configuring my hotkeys and keybindings!"
sudo rm -rf $HOME/configs.bak/
sudo mv $HOME/configs/ $HOME/configs.bak/
sudo cp -r configs/ $HOME; sudo cp ./*.txt /opt/; sudo cp tools.sh /tmp/; sudo chmod +x /tmp/tools.sh
cd $HOME/configs/ && sudo stow ack curl git input xinit xsession zsh
source $HOME/.zshrc
sudo rm -rf $HOME/.config/{nvim,qterminal.org}/
mkdir $HOME/.config/{nvim,qterminal.org}/
mkdir $HOME/.config/nvim/plugged
mkfile /etc/kali-motd/disable-all
sudo stow -S nvim -t $HOME/.config/nvim/
sudo stow -S qterminal -t $HOME/.config/qterminal.org/
mkdir $HOME/.dircolors

#Installing pip and dependencies
echo "Installing pip and dependencies!"
cd $HOME
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && sudo python3 get-pip.py
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py && sudo python2 get-pip.py
sudo python2 -m pip install --upgrade pip
sudo python3 -m pip install --upgrade pip
pip install -r /opt/requirements.txt
pip3 install -r /opt/requirements.txt
echo "done"

#Installing and configuring neovim
sudo rm -rf $HOME/.vim
sudo rm $HOME/.local/share/nvim/site/autoload/plug.vim
sudo curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
/usr/bin/zsh -c "nvim -c 'PlugInstall | qall!'"
cat /opt/coc-plug.txt | xargs -I {} /usr/bin/zsh -c "nvim -c 'CocInstall -sync coc-{} | qall!'"
nvim +qall

# #Installing flatpak and apps
# sudo apt install flatpak gnome-software-plugin-flatpak -y
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpack install flathub com.anydesk.Anydesk org.qbittorrent.qBittorrent us.zoom.Zoom -y
/tmp/tools.sh
updater
echo "Now you can update and upgrade your kali machine anytime by typing \"updater\" command!"
