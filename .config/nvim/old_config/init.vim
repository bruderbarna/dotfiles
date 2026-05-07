scriptencoding utf-8

let mapleader=","
let g:mapleader=","


lua require('plugins')

exec "set listchars=tab:>-,trail:\uBB,nbsp:~"

lua require('set')

" 'fix' typos
command! Q :q
command! Qa :qall
command! QA :qall
command! Qall :qall
command! QAll :qall
command! W :w
command! Wa :wa
command! Wq :wq
command! WQ :wq

lua require('keymap')
lua require('util')
lua require('lsp')
lua require('nvim-cmp')
