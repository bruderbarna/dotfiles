vim.mapleader = ","
vim.g.mapleader = ","

vim.keymap.set("n", "<leader>vrc", ":e $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>r", ":w<cr>:e<cr>")
vim.keymap.set("n", "<leader>/", ":noh<cr>")

vim.keymap.set("n", "<leader>ds", ":DiffSaved<cr>")
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>")
vim.keymap.set("n","<leader>m", ":NvimTreeFindFile<cr>")
vim.keymap.set("n", "<leader>a", "<C-^>")
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")
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

vim.keymap.set("n", "<leader>gb", "<cmd>G blame<cr>")

-- lspsaga
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-p>", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "<C-n>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
-- vim.keymap.set("n", "<leader>gd", "<Cmd>Lspsaga finder<CR>", opts)
vim.keymap.set("n", "<leader>gf", "<Cmd>Lspsaga finder<CR>", opts)
vim.keymap.set("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "<leader>gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "<leader>gr", "<Cmd>Lspsaga rename<CR>", opts)

