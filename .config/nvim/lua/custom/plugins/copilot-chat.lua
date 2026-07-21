vim.pack.add { 'https://github.com/CopilotC-Nvim/CopilotChat.nvim' }

require('CopilotChat').setup()

vim.keymap.set('n', '<leader>cc', function()
  require('CopilotChat').open()
end, { desc = 'Open Copilot Chat' })
