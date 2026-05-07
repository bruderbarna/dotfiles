vim.pack.add { 'https://github.com/nvim-tree/nvim-tree.lua' }

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup {
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 40,
  },
  renderer = {
    group_empty = true,
  },
  on_attach = function(bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc)
      return {
        desc = 'nvim-tree: ' .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts 'Up')
  end,
}

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>m', ':NvimTreeFindFile<cr>')
