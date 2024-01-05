scriptencoding utf-8

call plug#begin()

" tpope goodness
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" fugitive & bitbucket Gbrowse extension
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'

" text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-function'
Plug 'vim-scripts/ReplaceWithRegister'

" file tree
Plug 'scrooloose/nerdtree'
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1

" colorschemes
Plug 'arcticicestudio/nord-vim'

" autocomplete, code actions, lint and more
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" magic. used for project search
Plug 'Shougo/denite.nvim', {'tag': '3.2'}

" best thing ever
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

Plug 'https://github.com/adelarsq/vim-matchit'

" syntaxes
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
Plug 'posva/vim-vue'
Plug 'hashivim/vim-terraform'

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

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

set encoding=utf-8
set clipboard=unnamed
set hidden
set linespace=1
set number
set nowrap
set cursorline
set history=200
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set wildmenu
set ruler
set cmdheight=1
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set splitright splitbelow
set magic
set history=20
set showmatch
set mat=2
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
set t_vb=""
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
"   --files:  Print each file that would be searched (but don't search)
"   --glob:   Include or exclues files for searching that match the given glob
"             (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep: Show results with every match on it's own line
"   --hidden:  Search hidden directories and files
"   --heading: Show the file name above clusters of matches from each file
"   --S:       Search case insensitively if the pattern is all lowercase
"   --follow:  Follow symlinks
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S', '--follow'])

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

"Close preview window when completion is done.
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

" convenient little function that lets you choose a recent position to jump back to
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
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

com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

let mapleader=','
let g:mapleader=','

nnoremap <leader>vrc :e $MYVIMRC<cr>
nnoremap <leader>r :w<cr>:e<cr>
nnoremap <silent> <leader>/ :noh<cr>
nnoremap <leader>w :Windows<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>sw :%s/\bs\+$//e<cr>:noh<cr>

nnoremap <leader>ds :DiffSaved<cr>
nnoremap <leader>ox 0x$x:silent! %s/\\t//g<cr>:silent! %s/\\//g<cr>:FormatXML<cr>
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>rn <Plug>(coc-rename)
nnoremap <silent> <leader>ca :CocFix<cr>
nnoremap <silent> K :call <SID>show_documentation()<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>m :NERDTreeFind<cr>
nnoremap <leader>a <C-^>
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>
vnoremap > >gv
vnoremap < <gv
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap n nzz
nnoremap N Nzz
nnoremap <F1> <Nop>
inoremap <F1> <Nop>
nnoremap j gj
ino <left> <Nop>
ino <right> <Nop>
ino <down> <Nop>
ino <up> <Nop>
" visual line movement
nnoremap j gj
nnoremap k gk

" telescope
nnoremap <leader>j <cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand("<cword>")})<cr>
nnoremap <leader>s <cmd>Telescope live_grep<cr>
nnoremap <leader>f <cmd>Telescope git_files<cr>
nnoremap <leader>F <cmd>lua require('telescope.builtin').find_files({follow = true})<cr>

" terminal related rebinds
tnoremap <Esc> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" fugitive extra commands
command! GLog :Git -p log --graph
command! Glog :Gl
command! Gl :Gl
command! GL :Gl

" fugitive binds
nnoremap <leader>Gd :Gdiff<cr>
nnoremap <leader>Gs :Gstatus<cr>
nnoremap <leader>Gl :GLog<cr>

" 'fix' typos
command! Q :q
command! Qa :qall
command! QA :qall
command! Qall :qall
command! QAll :qall
command! W :w
command! Wa :wa
