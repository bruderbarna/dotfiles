require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<up>"] = require("telescope.actions").cycle_history_prev,
				["<down>"] = require("telescope.actions").cycle_history_next,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
