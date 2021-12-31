call plug#begin('$HOME/.config/nvim/plugged')
    Plug 'tpope/vim-fugitive' " git
    Plug 'sjl/gundo.vim' " graphical undo
    Plug 'godlygeek/tabular' " tables
    Plug 'scrooloose/nerdtree' " explorer
    Plug 'b3nj5m1n/kommentary' " comments toggle
    Plug 'dhruvasagar/vim-zoom' " toggle zoom splits
    Plug 'francoiscabrol/ranger.vim' " ranger in vim
    Plug 'romgrk/barbar.nvim' " status bar (top)
    Plug 'nvim-lualine/lualine.nvim' " status line (bottom)
    Plug 'kyazdani42/nvim-web-devicons' " programming icons
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot' " language support
    Plug 'junegunn/rainbow_parentheses.vim' " Coloured brackets
    Plug 'tomasiser/vim-code-dark' " colorscheme
    Plug 'mfussenegger/nvim-dap' " debugger
    Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " markdown preview
call plug#end()