vim.mapleader = ","
vim.g.mapleader = ","

vim.keymap.set("n", "<leader>vrc", ":e $MYVIMRC<cr>")

vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>")
vim.keymap.set("n","<leader>m", ":NvimTreeFindFile<cr>")
vim.keymap.set("n", "<leader>a", "<C-^>")
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
-- vim.keymap.set("n", "<C-j>", "<C-W>j")
-- vim.keymap.set("n", "<C-k>", "<C-W>k")
-- vim.keymap.set("n", "<C-h>", "<C-W>h")
-- vim.keymap.set("n", "<C-l>", "<C-W>l")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<F1>", "<Nop>")
vim.keymap.set("i", "<F1>", "<Nop>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("i", "<left>", "<Nop>")
vim.keymap.set("i", "<right>", "<Nop>")
vim.keymap.set("i", "<down>", "<Nop>")
vim.keymap.set("i", "<up>", "<Nop>")
-- visual line movement
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set(
  "n",
  "<leader>j",
  '<cmd>lua require("telescope.builtin").grep_string({search = vim.fn.expand("<cword>")})<cr>'
)
vim.keymap.set("n", "<leader>s", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>S", function()
  require("telescope.builtin").live_grep({
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "-uu",
    },
  })
end)
vim.keymap.set("n", "<leader>f", "<cmd>Telescope git_files<cr>")
vim.keymap.set("n", "<leader>F", '<cmd>lua require("telescope.builtin").find_files({follow = true})<cr>')
vim.keymap.set("n", "<leader>r", '<cmd>lua require("telescope.builtin").oldfiles()<cr>')
vim.keymap.set("n", "<leader>/", function ()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer'})
vim.keymap.set('n', '<leader>qh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>qd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>qe', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

vim.keymap.set("n", "<leader>gb", "<cmd>G blame<cr>")

-- new
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
