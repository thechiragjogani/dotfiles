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