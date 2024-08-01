#!/usr/bin/bash
# No annoying password prompts
CURRENTUSER=$(whoami); sudo echo -e "\n$CURRENTUSER  ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
echo "Removing boilerplate home directories!"

mv $HOME/Downloads/* $HOME 2>/dev/null
sudo rm -rf $HOME/{.vim,Downloads,Pictures,Documents,Music,Videos} 2>/dev/null

#Updating sources with fast mirrors
echo "deb http://downloads.metasploit.com/data/releases/metasploit-framework/apt kali main" | sudo tee /etc/apt/sources.list
echo "deb https://mirror.kku.ac.th/kali kali-rolling main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list
echo "deb-src https://mirror.kku.ac.th/kali kali-rolling main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list

echo -e 'HostKeyAlgorithms ssh-rsa,ssh-dss\nPubkeyAcceptedKeyTypes ssh-rsa,ssh-dss' | sudo tee /etc/ssh/ssh_config.d/my.conf

echo "Fixing GPG key errors if there are any! Please wait!"
sudo rm -rf /var/lib/apt/lists
sudo apt update 2>&1 1>/dev/null | sed -ne 's/.*NO_PUBKEY //p' | while read key; do if ! [[ ${keys[*]} =~ "$key" ]]; then sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "0x$key"; keys+=("$key"); fi; done
for KEY in $(apt-key --keyring /etc/apt/trusted.gpg list | grep -E "(([ ]{1,2}(([0-9A-F]{4}))){10})" | tr -d " " | grep -E "([0-9A-F]){8}\b" ); do K=${KEY:(-8)}; sudo rm /etc/apt/trusted.gpg.d/imported-from-trusted-gpg-$K.gpg; apt-key export $K | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/imported-from-trusted-gpg-$K.gpg; done

sudo apt update -y
sudo apt install -y kali-archive-keyring git stow python3 neovim curl python3 zsh tmux texlive-latex-recommended texlive-fonts-extra texlive-latex-extra pandoc evince 2>/dev/null


sudo mkdir -p /usr/share/pandoc/data/templates/
sudo cp eisvogel.latex /usr/share/pandoc/data/templates/

cp *.txt $HOME/Tools

sudo mkdir -p /etc/kali-motd/
sudo touch /etc/kali-motd/disable-all

#Installing required packages
sudo apt update -y 2>/dev/null
sudo apt --fix-broken install -y 2>/dev/null
sudo apt upgrade -y 2>/dev/null
sudo apt dist-upgrade -y 2>/dev/null
sudo apt install -f 2>/dev/null
sudo apt autoremove -y 2>/dev/null
sudo apt autoclean -y 2>/dev/null
sudo apt clean -y 2>/dev/null

#Installing custom configs
echo "Installing custom configs!"
cd $HOME; git clone https://github.com/thechiragjogani/configs.git

sudo rm $HOME/.zsh*
cd $HOME/configs/ && stow ack curl git input tmux xinit xsession zsh -t $HOME

sudo rm $HOME/.local/share/nvim/site/autoload/plug.vim
sudo rm -rf $HOME/.config/{nvim,qterminal.org}/
mkdir $HOME/.config/{nvim,qterminal.org}/
mkdir $HOME/.config/nvim/{lua,plugged}/
stow -S qterminal -t $HOME/.config/qterminal.org/
stow -S nvim-plug -t $HOME/.config/nvim/

echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf
sudo service NetworkManager restart
sleep 5

mkdir -p $HOME/.local/share/nvim/site/autoload/
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O $HOME/.local/share/nvim/site/autoload/plug.vim
/usr/bin/zsh -c "nvim -c 'so $HOME/configs/nvim/init.vim | PlugInstall | qall!'"
stow -S nvim -t $HOME/.config/nvim/

mkdir -p $HOME/ctf
mkdir -p $HOME/ctf/{htb,thm}
touch $HOME/ctf/target

cd $HOME/dotfiles
./tools.sh

sudo rm $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
cd $HOME/configs/ && stow -S xfce -t $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/

echo "Now you can update and upgrade your kali machine anytime by typing \"updater\" command!"
echo "Please restart your machine to apply all the changes!"
