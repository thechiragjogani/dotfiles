# History control
HISTCONTROL=ignoredups:ignorespace:ignoreboth
HISTSIZE=100000
HISTFILESIZE=2000000
shopt -s histappend
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

export PS1="\[\033[1;32m\]\342\224\214\342\224\200$([[ $(/opt/vpnbash.sh) == *"10."* ]] && echo "[\[\033[1;34m\]$(/opt/vpnserver.sh)\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]$(/opt/vpnbash.sh)\[\033[1;32m\]]\342\224\200")[\[\033[1;31m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]\w\[\033[1;32m\]]\n\[\033[1;32m\]\342\224\224\342\224\200\342\224\200\342\225\274 [\[\e[01;33m\]*\[\e[01;32m\]]\\$ \[\e[0m\]"

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
	man() {
	env \
	LESS_TERMCAP_mb=$'\e[01;31m' \
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	man "$@"
	}
fi

unset color_prompt force_color_prompt

# COLOURS!
export TERM=xterm-256color

# VIM as default editor
export EDITOR=/usr/bin/vim


# Local settings go last
if [ -f ~/.localrc ]; then 
  source ~/.localrc
fi

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.local/bin:/usr/.local/bin/usr/local/games:/usr/games:/usr/share/games:/snap/bin:$GOPATH/bin:$GOROOT/bin:$PATH

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/*
sudo ln -s /var/lib/snapd/desktop/applications/ /usr/share/applications/snap
source ~/.bash_aliases
source ~/.bash_funcs
