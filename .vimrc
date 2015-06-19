set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
syntax enable
filetype indent plugin on
call pathogen#infect()
"set paste
set clipboard=unnamed
set noesckeys
let g:airline_powerline_fonts=1
let g:airline_theme='badwolf'

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set encoding=utf-8
set hidden
set linespace=1
set nu
set rnu
set wrap
set history=200
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set so=4
set wildmenu
set ruler
set cmdheight=1
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set history=20
set showmatch
set mat=2
set numberwidth=5
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \l:\ %l\ c:\ %c
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \l:\ %l\ c:\ %c
set noerrorbells
set novisualbell
set t_vb=""
set tm=500
set nobackup
set nowb
set noswapfile
set viminfo^=%
set laststatus=2
set cursorline
exec "set listchars=trail:\uBB,nbsp:~"
set nolist
set t_vb=""
set makeprg=gcc\ %\ -o\ %:r.exe

set term=xterm
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=L
    set guioptions+=e
    set guitablabel=%M\ %t
    set lines=30 columns=100
    colorscheme railscasts
endif

set t_Co=256
set t_ut=

let mapleader=','
let g:mapleader=','

nnoremap n nzz
nnoremap N Nzz
"inoremap jk <esc>
"inoremap <esc> <nop>
nnoremap <c-i> "fddO
nnoremap <c-t> :b#<cr>
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprev<cr>
command! Q :q
"inoremap jk <esc>
"inoremap <esc> <nop>
nnoremap <leader>vrc :e $MYVIMRC<cr>
nnoremap <leader>f :NERDTreeToggle<cr>
"nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
command! Q :q
nnoremap <leader>lf :CtrlP<cr>
nnoremap <leader>/ :silent noh<cr>
nnoremap <leader>o o<esc>k
vnoremap > >gv
vnoremap < <gv
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <down> <c-n>
ino <up> <c-p>

if &term =~ "xterm"
  " 256 colors
  let &t_Co = 256
  " restore screen after quitting
  let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
  let &t_te = "\<Esc>[?47l\<Esc>8"
  if has("terminfo")
    let &t_Sf = "\<Esc>[3%p1%dm"
    let &t_Sb = "\<Esc>[4%p1%dm"
  else
    let &t_Sf = "\<Esc>[3%dm"
    let &t_Sb = "\<Esc>[4%dm"
  endif
endif
colorscheme apprentice

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

set smartindent
