vim.opt.encoding = "utf-8"
vim.opt.clipboard = "unnamedplus"
vim.opt.hidden = true
vim.opt.linespace = 1
vim.opt.number = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.history = 200
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wildmenu = true
vim.opt.ruler = true
vim.opt.cmdheight = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.magic = true
vim.opt.history = 20
vim.opt.showmatch = true
vim.opt.mat = 2
vim.opt.numberwidth = 5
vim.opt.statusline = " %F%m%r%h %w%=%{FugitiveStatusline()} l: %l c: %c "
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.timeoutlen = 500
-- vim.opt.viminfo^=lua/%
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.updatetime = 300
vim.opt.termguicolors = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- new
vim.o.breakindent = true
vim.o.undofile = true
vim.wo.signcolumn = "yes"
vim.o.completeopt = "menuone,noselect"
