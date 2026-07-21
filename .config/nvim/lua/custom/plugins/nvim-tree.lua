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

_G.started_from_stdin = false

vim.api.nvim_create_autocmd({ 'StdinReadPre' }, {
  callback = function()
    _G.started_from_stdin = true
  end,
})

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function(data)
    local started_in_dir = function()
      return vim.fn.isdirectory(data.file) == 1
    end
    local file_not_under_cwd = function()
      return data.file ~= '' and vim.fn.fnamemodify(data.file, ':p:h') ~= vim.fn.getcwd()
    end

    if _G.started_from_stdin or started_in_dir() or file_not_under_cwd() then
      return
    end

    require('nvim-tree.api').tree.open()
    -- jump back to the opened file's window or new empty buffer's window
    vim.fn.win_gotoid(vim.fn.win_getid(vim.fn.winnr '#'))
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    if vim.fn.winnr '$' == 1 and vim.bo.filetype == 'NvimTree' and vim.fn.argv(0, vim.fn.winnr '$') ~= 'NvimTree_1' then
      vim.cmd 'quit'
    end
  end,
})

vim.keymap.set('n', '<leader>n', ':NvimTreeFocus<cr>')
vim.keymap.set('n', '<leader>m', ':NvimTreeFindFile<cr>')
