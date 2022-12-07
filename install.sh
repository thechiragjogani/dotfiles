#!/usr/bin/bash
echo "Removing boilerplate home directories!"
mv $HOME/Downloads/* $HOME
sudo rm -rf $HOME/{.vim,Downloads,Pictures,Documents,Music,Videos}

#Updating sources with fast mirrors
echo "deb http://downloads.metasploit.com/data/releases/metasploit-framework/apt kali main" | sudo tee /etc/apt/sources.list
echo "deb https://mirrors.ocf.berkeley.edu/kali kali-rolling main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src https://mirrors.ocf.berkeley.edu/kali kali-rolling main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb https://mirrors.ocf.berkeley.edu/debian bullseye main contrib non-free" | sudo tee -a /etc/apt/sources.list
echo "deb-src https://mirrors.ocf.berkeley.edu/debian bullseye main contrib non-free" | sudo tee -a /etc/apt/sources.list

echo "Fixing GPG key errors if there are any!"
sudo rm -rf /var/lib/apt/lists
sudo apt update -y
sudo apt update 2>&1 1>/dev/null | sed -ne 's/.*NO_PUBKEY //p' | while read key; do if ! [[ ${keys[*]} =~ "$key" ]]; then sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "0x$key"; keys+=("$key"); fi; done
for KEY in $(apt-key --keyring /etc/apt/trusted.gpg list | grep -E "(([ ]{1,2}(([0-9A-F]{4}))){10})" | tr -d " " | grep -E "([0-9A-F]){8}\b" ); do K=${KEY:(-8)}; sudo rm /etc/apt/trusted.gpg.d/imported-from-trusted-gpg-$K.gpg; apt-key export $K | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/imported-from-trusted-gpg-$K.gpg; done
sudo apt update -y
sudo apt install -y kali-archive-keyring git stow python3 neovim curl python3-pip python3-venv zsh python2 tmux

sudo cp *.txt /opt/

#Installing pip and dependencies
echo "Installing pip and dependencies!"
wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py && sudo python3 get-pip.py
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py -O get-pip.py && sudo python2 get-pip.py
sudo python2 -m pip install --upgrade pip
sudo python3 -m pip install --upgrade pip
sudo pip install -r /opt/requirements.txt
sudo pip3 install -r /opt/requirements.txt

sudo mkdir -p /etc/kali-motd/
sudo touch /etc/kali-motd/disable-all
dircolors -p > $HOME/.dircolors

#Installing custom configs
echo "Installing custom configs!"
sudo rm $HOME/.zshrc
sudo rm $HOME/.local/share/nvim/site/autoload/plug.vim
sudo rm $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
sudo rm -rf $HOME/.config/{nvim,qterminal.org}/
cd $HOME; git clone https://github.com/thechiragjogani/configs.git
cd $HOME/configs/ && sudo stow ack curl git input tmux xinit xsession zsh -t $HOME
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

cd ~/dotfiles
./tools.sh
#Installing required packages
cat /opt/packages.txt | xargs -I {} /usr/bin/zsh -c 'sudo apt install -y {} 2> /dev/null'

sudo apt --fix-broken install -y 2> /dev/null;
sudo apt-get update -y 2> /dev/null;
sudo apt-get upgrade -y 2> /dev/null;
sudo apt-get dist-upgrade -y 2> /dev/null;
sudo apt-get install kali-linux-everything -y 2> /dev/null;
sudo apt-get update -y 2> /dev/null;
sudo apt autoremove -y 2> /dev/null;
sudo apt autoclean -y 2> /dev/null;
sudo apt clean -y 2> /dev/null;
sudo apt-get install -f 2> /dev/null;
cat /opt/labs.txt | xargs -I {} /usr/bin/zsh -c 'sudo docker pull {} 2> /dev/null'
cat /opt/lsp.txt | xargs -I {} /usr/bin/zsh -c 'sudo npm i -g {} 2> /dev/null'

echo "Now you can update and upgrade your kali machine anytime by typing \"updater\" command!"
