vim.pack.add { 'https://github.com/christoomey/vim-tmux-navigator' }

vim.keymap.set('n', '<C-h>', '<Cmd><C-U>TmuxNavigateLeft<CR>')
vim.keymap.set('n', '<C-j>', '<Cmd><C-U>TmuxNavigateDown<CR>')
vim.keymap.set('n', '<C-k>', '<Cmd><C-U>TmuxNavigateUp<CR>')
vim.keymap.set('n', '<C-l>', '<Cmd><C-U>TmuxNavigateRight<CR>')
