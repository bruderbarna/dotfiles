scriptencoding utf-8

syntax enable

call plug#begin()

" tpope goodness
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'

" text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-function'
Plug 'vim-scripts/ReplaceWithRegister'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'

" file tree
Plug 'scrooloose/nerdtree'
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1

" colorschemes
Plug 'arcticicestudio/nord-vim'

" best thing ever
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" misc convenience oriented plugins
Plug 'editorconfig/editorconfig-vim'
Plug 'jesseleite/vim-noh'
Plug 'christoomey/vim-tmux-navigator'

" auto pairs
Plug 'jiangmiao/auto-pairs'
" no silly multiline matching
let g:AutoPairsMultilineClose=0
" disable toggle shortcut
let g:AutoPairsShortcutToggle = ''

" go
Plug 'fatih/vim-go'

call plug#end()
filetype plugin indent on

" luafile ~/dotfiles/compe-config.lua
" luafile ~/dotfiles/lsp-tsserver.lua

set encoding=utf-8
set clipboard=unnamed
set hidden
set number
set nowrap
set cursorline
set history=200
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set wildmenu
set cmdheight=1
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set splitright splitbelow
set magic
set matchpairs+=<:>
set numberwidth=5
set statusline=\ %F%m%r%h\ %w%=%{FugitiveStatusline()}\ \ \l:\ %l\ c:\ %c\ 
set noerrorbells
set novisualbell
set t_vb=""
set tm=500
set viminfo^=%
set laststatus=2
exec "set listchars=tab:>-,trail:\uBB,nbsp:~"
set list
set mouse=a
set updatetime=300
set colorcolumn=100

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" color
" set t_8f=[38;2;%lu;%lu;%lum
" set t_8b=[38;2;%lu;%lu;%lum
colorscheme nord
" set termguicolors
" set t_Co=256

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

let mapleader=','
let g:mapleader=','
nnoremap <leader>vrc :e $MYVIMRC<cr>
nnoremap <leader>r :w<cr>:e<cr>
nnoremap <silent> <leader>/ :noh<cr>
nnoremap <leader>a <C-^>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>m :NERDTreeFind<cr>
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>
vnoremap > >gv
vnoremap < <gv
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap n nzz
nnoremap N Nzz
nnoremap <F1> <Nop>
inoremap <F1> <Nop>
" visual line movement
nnoremap j gj
nnoremap k gk

" 'fix' typos
command! Q :q
command! Qa :qall
command! QA :qall
command! Qall :qall
command! QAll :qall
command! W :w
command! WQ :wq
command! Wq :wq
command! Wa :wa

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
