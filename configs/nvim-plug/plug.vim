call plug#begin('$HOME/.config/nvim/plugged')
    Plug 'tpope/vim-fugitive' " git
    Plug 'sjl/gundo.vim' " graphical undo
    Plug 'b3nj5m1n/kommentary' " comments toggle
    Plug 'romgrk/barbar.nvim' " status bar (top)
    Plug 'nvim-lualine/lualine.nvim' " status line (bottom)
    Plug 'kyazdani42/nvim-web-devicons' " programming icons
    Plug 'junegunn/rainbow_parentheses.vim' " Coloured brackets
    Plug 'tomasiser/vim-code-dark' " colorscheme
    Plug 'mfussenegger/nvim-dap' " debugger
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " markdown preview
    Plug 'lambdalisue/suda.vim' " sudo write
    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " file explorer
    Plug 'neovim/nvim-lspconfig'
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " code completion
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " 9000+ Snippets
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
call plug#end()