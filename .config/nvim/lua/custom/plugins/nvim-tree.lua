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
    api.map.on_attach.default(bufnr)

    -- custom mappings
    vim.keymap.set('n', 'cd', api.tree.change_root_to_node, opts 'Up')
  end,
}

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 then
      return
    end

    -- if a file is opened and opened file's directory is not a subpath of the current working directory, then return
    if data.file ~= '' and vim.fn.fnamemodify(data.file, ':p:h') ~= vim.fn.getcwd() then
      return
    end

    require('nvim-tree.api').tree.open()
    -- jump back to the opened file's window or new empty buffer's window
    vim.fn.win_gotoid(vim.fn.win_getid(vim.fn.winnr '#'))
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    if vim.fn.winnr '$' == 1 and vim.bo.filetype == 'NvimTree' then
      vim.cmd 'quit'
    end
  end,
})

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>m', ':NvimTreeFindFile<cr>')
