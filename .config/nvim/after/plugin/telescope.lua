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
