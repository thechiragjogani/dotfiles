#!/usr/bin/zsh
echo "Removing boilerplate home directories!"
mv $HOME/Downloads/* $HOME
sudo rm -rf $HOME/{.vim,Downloads,Pictures,Documents,Music,Videos}

#Updating sources with fast mirrorscurl
https://c.quick-lint-js.com/quick-lint-js-release.key | sudo apt-key add -
echo "deb https://mirrors.ocf.berkeley.edu/kali kali-rolling main contrib non-free\ndeb-src https://mirrors.ocf.berkeley.edu/kali kali-rolling main contrib non-free\ndeb https://mirrors.ocf.berkeley.edu/debian sid main contrib non-free\ndeb-src https://mirrors.ocf.berkeley.edu/debian sid main contrib non-free\ndeb [arch=amd64] https://c.quick-lint-js.com/debian experimental main\n" | sudo tee /etc/apt/sources.list

echo "Fixing GPG key errors if there are any!"
sudo rm -rf /var/lib/apt/lists
sudo apt update 2>&1 1>/dev/null | sed -ne 's/.*NO_PUBKEY //p' | while read key; do if ! [[ ${keys[*]} =~ "$key" ]]; then sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys "$key"; keys+=("$key"); fi; done
sudo apt update -y
sudo apt install -y kali-archive-keyring git stow python3 neovim curl python3-pip python3-venv

#Installing pip and dependencies
echo "Installing pip and dependencies!"
cd /tmp/
wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py && sudo python3 get-pip.py
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py -O get-pip.py && sudo python2 get-pip.py
sudo python2 -m pip install --upgrade pip
sudo python3 -m pip install --upgrade pip
pip install -r /opt/requirements.txt
pip3 install -r /opt/requirements.txt
echo "done"

sudo mkdir -p /etc/kali-motd/
sudo touch /etc/kali-motd/disable-all
dircolors -p > ~/.dircolors
eval "dircolors -b ~/.dircolors"

cd $HOME; git clone https://github.com/thechiragjogani/configs.git
cd $HOME/configs/ && sudo stow ack curl git input tmux xinit xsession zsh -t $HOME
sudo rm $HOME/.local/share/nvim/site/autoload/plug.vim
sudo rm $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
sudo rm -rf $HOME/.config/{nvim,qterminal.org}/
mkdir $HOME/.config/{nvim,qterminal.org}/
mkdir $HOME/.config/nvim/{lua,plugged}/
sudo stow -S qterminal -t $HOME/.config/qterminal.org/
sudo stow -S xfce -t $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
sudo stow -S nvim-plug -t $HOME/.config/nvim/
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
/usr/bin/zsh -c "nvim -c 'so $HOME/.config/nvim/plug.vim | PlugInstall | qall!'"
sudo stow -S nvim -t $HOME/.config/nvim/

# #Installing flatpak and apps
# sudo apt install flatpak gnome-software-plugin-flatpak -y
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpack install flathub com.anydesk.Anydesk org.qbittorrent.qBittorrent us.zoom.Zoom -y

/tmp/tools.sh
#Installing required packages
cat /opt/packages.txt | xargs -I {} /usr/bin/zsh -c 'sudo apt install -y {} 2> /dev/null'

updater

cat /opt/lsp.txt | xargs -I {} /usr/bin/zsh -c 'sudo npm i -g {} 2> /dev/null'

echo "Now you can update and upgrade your kali machine anytime by typing \"updater\" command!"