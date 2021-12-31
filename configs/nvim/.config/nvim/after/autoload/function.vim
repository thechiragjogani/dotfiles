if has("autocmd")
  augroup vim
    autocmd!
    autocmd filetype vim set textwidth=80
  augroup END
  augroup windows
    autocmd!
    autocmd VimResized * :wincmd = " resize splits when the window is resized
  augroup END
    augroup trailing_spaces
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e " remove trailing spaces before saving
  augroup END
  augroup restore_cursor
    " restore cursor position to last position upon file reopen
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  augroup END
  augroup command
    autocmd!
    autocmd CmdwinEnter * noremap <buffer> <silent> <C-c> <ESC>:q<CR> " CTRL+C closes the command window
  augroup END

endif
map <leader>r :call CompileRun()<CR>
imap <leader>r <Esc>:call CompileRun()<CR>
vmap <leader>r <Esc>:call CompileRun()<CR>

func! CompileRun()
exec "w"
if &filetype == 'c'
    exec "!sudo gcc % -o % && ./%<"
elseif &filetype == 'cpp'
    exec "!sudo g++ % -o % && ./%<"
elseif &filetype == 'java'
    exec "!java %"
elseif &filetype == 'sh'
    exec "!bash %"
elseif &filetype == 'python'
    exec "!python3 %"
elseif &filetype == 'html'
    exec "!firefox % &"
elseif &filetype == 'go'
    exec "!go build % && go run %"
endif
endfunc