let mapleader=" " " change leader key to <space>
let maplocalleader=" " " change local leader key to <space>

nnoremap <leader>sv :source $HOME/.config/nvim/init.vim<CR>:runtime!<CR>:redraw<CR> " <leader>sv sources init.vim

" All modes Mappings
map <leader>u <Esc>:GundoToggle<CR> " Toggle graphical undo
map <F9> <Esc><C-W>gF<CR>:tabm<CR> " Open file under cursor in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " Open word under cursor as ctag in new tab
map <F1> gg=G " Formats document
map <leader>w :SudaWrite<CR>
map <leader>1 1gt " Tab 1
map <leader>2 2gt " Tab 2
map <leader>3 3gt " Tab 3
map <leader>4 4gt " Tab 4
map <leader>5 5gt " Tab 5
map <leader>6 6gt " Tab 6
map <leader>7 7gt " Tab 7
map <leader>8 8gt " Tab 8
map <leader>9 9gt " Tab 9
noremap <silent> <leader>sw :%s/\\s\\+$//e<CR> " Remove trailing whitespaces
noremap <silent> <leader>$ :%s/<C-V><CR>//e<CR> " <leader>$ fixes mixed EOLs (^M)
noremap <silent><leader>jj :m+<CR> " move current line down
noremap <silent><leader>kk :m-2<CR> " move current line up

" Normal mode Mappings
nmap <leader>g :tabnew\|read !grep -Hnr '<C-R><C-W>'<CR> " grep recursively for word under cursor
nmap <leader>b :!echo <C-R><C-W> \| dcode <CR> " Decode word under cursor
nmap <leader>s :%!sort -u --version-sort<CR> " Sort the buffer removing duplicates
nmap <C-h> <C-w>h " Quick window switching left
nmap <C-j> <C-w>j " Quick window switching down
nmap <C-k> <C-w>k " Quick window switching up
nmap <C-l> <C-w>l " Quick window switching right
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <leader>W :wa!<CR> " <leader>W writes all buffers
nnoremap <silent> <leader>cd :cd %:p:h<CR> " cd to the directory of the current buffer
nnoremap <leader><Tab> <c-^> " switch between last two files
nnoremap U <C-r> " remap U to <C-r> for easier redo
nnoremap v <C-V> " make v enter blockwise visual mode, and CTRL-V enter visual mode
nnoremap <C-V> v " make v enter blockwise visual mode, and CTRL-V enter visual mode
nnoremap <C-s> <C-w>s " split current window horizontally
nnoremap <leader>t <Esc>:tabe " New Tab
nnoremap <silent> <leader>q :wq!<CR> " <leader>q quits the current window
nnoremap <silent> yf :let @+=expand('%:p')<CR> " copies filepath to clipboard
nnoremap <silent> <leader><Enter> :Buffers<CR> " list buffers
nnoremap <silent> <expr> <leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>" " Toggle nerdtree at current file
" Move to previous/next buffer
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next buffer
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
nnoremap <silent>    <A-p> :BufferPin<CR>
nnoremap <silent>    <leader>bc :BufferClose<CR>
" Magic buffer-picking mode
nnoremap <silent> <leader>sb    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <leader>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <leader>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <leader>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <leader>bw :BufferOrderByWindowNumber<CR>

" Insert mode Mappings
inoremap <silent> <leader>w <ESC>:w!<CR> " <leader>w writes the whole buffer to the current file
inoremap <silent> <leader>W <ESC>:wa!<CR> " <leader>W writes all buffers
inoremap jk <ESC>`^ " exit from insert mode without cursor movement
inoremap <C-Space> <C-P> " <C-Space> triggers completion in insert mode
" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

" Command mode Mappings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
"save the session, save modified files, and exit
command! Xs :mks! | :xa

" Visual mode Mappings
" move visual selection down and up
vnoremap <silent><leader>j :m '>+1<CR>gv=gv
vnoremap <silent><leader>k :m '<-2<CR>gv=gv
" indent / un-indent in visual and select modes
vnoremap > >gv
vnoremap < <gv
vnoremap . :normal .<CR> " make dot work in visual mode
vnoremap v <C-V> " make v enter blockwise visual mode, and CTRL-V enter visual mode
vnoremap <C-V> v " make v enter blockwise visual mode, and CTRL-V enter visual mode
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>