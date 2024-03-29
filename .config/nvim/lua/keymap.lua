vim.keymap.set("n", "<leader>vrc", ":e $MYVIMRC<cr>")

vim.keymap.set("n", "<leader>a", "<C-^>")
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")
vim.keymap.set("n", "<leader>/", ":noh<cr>")
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

-- new
vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { desc = "Open floating diagnostic message" }
)
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostics list" }
)

vim.keymap.set("x", "p", "P")
