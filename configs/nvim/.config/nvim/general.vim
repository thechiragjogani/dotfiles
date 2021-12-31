syntax on
filetype on
filetype plugin on
filetype indent on
set encoding=utf-8  " set vim encoding to UTF-8
set nocompatible    " use vim defaults
set nomodeline      " disable mode lines (security measure)
set history=1000 undolevels=1000
set ls=2 swapfile dir=/tmp/     " swap location
set noshowmode showcmd cmdheight=1
set ruler nu rnu
set nowrap autoindent
set ignorecase smartcase gdefault showmatch
set hidden autowrite autowriteall nobomb switchbuf=usetab fsync
set backspace=eol,start,indent
set tabstop=4 softtabstop=4 expandtab shiftround shiftwidth=4 smarttab
set mouse=
set wildmenu wildmode=longest:full,full wildignore+=.git wildignore+=*.DS_Store
set nofoldenable
set noesckeys
set shellcmdflag=-ci
set noerrorbells mousehide
set linespace=2
set startofline " move to first non-blank of the line when using PageUp/PageDown
set scrolloff=8     " number of lines to keep above and below the cursor
set splitright split
set nojoinspaces showmatch matchtime=4 matchpairs+=<:>
set clipboard+=unnamed
set completeopt=longest,menuone,preview " better completion
set diffopt+=vertical
set nobackup nowritebackup
set termguicolors
colorscheme codedark

" -- tmux integration ----------------------------------------------------------
" make arrow keys, home/end/pgup/pgdown, and function keys work when inside tmux
if exists('$TMUX') && (system("tmux show-options -wg xterm-keys | cut -d' ' -f2") =~ '^on')
  " tmux will send xterm-style keys when its xterm-keys option is on
  " add 'setw -g xterm-keys on' to your ~/.tmux.conf
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
  execute "set <xHome>=\e[1;*H"
  execute "set <xEnd>=\e[1;*F"
  execute "set <Insert>=\e[2;*~"
  execute "set <Delete>=\e[3;*~"
  execute "set <PageUp>=\e[5;*~"
  execute "set <PageDown>=\e[6;*~"
  execute "set <xF1>=\e[1;*P"
  execute "set <xF2>=\e[1;*Q"
  execute "set <xF3>=\e[1;*R"
  execute "set <xF4>=\e[1;*S"
  execute "set <F5>=\e[15;*~"
  execute "set <F6>=\e[17;*~"
  execute "set <F7>=\e[18;*~"
  execute "set <F8>=\e[19;*~"
  execute "set <F9>=\e[20;*~"
  execute "set <F10>=\e[21;*~"
  execute "set <F11>=\e[23;*~"
  execute "set <F12>=\e[24;*~"
endif