scriptencoding utf-8

syntax enable

call plug#begin()

" tpope goodness
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'

" text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-function'
Plug 'vim-scripts/ReplaceWithRegister'

" tree sitter highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" file tree
Plug 'scrooloose/nerdtree'
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1

" colorschemes
Plug 'arcticicestudio/nord-vim'

" autocomplete, code actions, lint and more
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" magic. used for project search
Plug 'Shougo/denite.nvim', { 'tag': '3.2' }

" best thing ever
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" syntaxes
Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'MaxMEllon/vim-jsx-pretty'

" misc convenience oriented plugins
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
Plug 'editorconfig/editorconfig-vim'
Plug 'jesseleite/vim-noh'
Plug 'christoomey/vim-tmux-navigator'

" auto pairs
Plug 'jiangmiao/auto-pairs'
" no silly multiline matching
let g:AutoPairsMultilineClose=0
" disable toggle shortcut
let g:AutoPairsShortcutToggle = ''

call plug#end()
filetype plugin indent on

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

" color
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[38;2;%lu;%lu;%lum
colorscheme nord
set termguicolors
set t_Co=256

try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

function! s:denite_mappings() abort
    nnoremap <silent><buffer><expr> t denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> h denite#do_map('do_action', 'split')
endfunction

augroup DENITE
    autocmd!
    autocmd FileType denite call s:denite_mappings()
augroup end

" Custom options for Denite
let s:denite_options = {'default' : {
\ 'split': 'horizontal',
\ 'start_filter': 1,
\ 'auto_resize': 0,
\ 'source_names': 'short',
\ 'prompt': 'λ:',
\ 'statusline': 0,
\ 'highlight_matched_char': 'WildMenu',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'StatusLine',
\ 'highlight_prompt': 'StatusLine',
\ 'winrow': 1,
\ 'vertical_preview': 1,
\ 'preview_width': 150
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <cr>          - Open currently selected file in any mode
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <cr>
  \ denite#do_map('do_action')
endfunction

" Define mappings while in denite window
"   <cr>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <cr>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
endfunction

" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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

" fzf extension: include untracked git files
function! s:FzfGitFilesWithUntracked()
    call fzf#run(fzf#wrap({'source': '{ git ls-files & git ls-files --exclude-standard --others | sort | uniq; }'}))
endfunction
com! FzfGitFilesWithUntracked call s:FzfGitFilesWithUntracked()

let mapleader=','
let g:mapleader=','
nnoremap <leader>vrc :e $MYVIMRC<cr>
nnoremap <leader>r :w<cr>:e<cr>
nnoremap <silent> <leader>/ :noh<cr>
nnoremap <leader>f :FzfGitFilesWithUntracked<cr>
nnoremap <leader>a <C-^>
nnoremap <leader>F :Files<cr>
nnoremap <leader>s :<C-u>Denite grep:. -no-empty<cr>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<cr>
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>rn <Plug>(coc-rename)
nnoremap <silent> <leader>ca :CocFix<cr>
nnoremap <silent> K :call <SID>show_documentation()<cr>
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

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = { enable = true },
}
EOF
