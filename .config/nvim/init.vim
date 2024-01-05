scriptencoding utf-8

lua require('plugins')

exec "set listchars=tab:>-,trail:\uBB,nbsp:~"
lua require('set')

colorscheme nord

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" diff current buffer with corresponding file on disk
function! s:DiffSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffSaved()

com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

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
