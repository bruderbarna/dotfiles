local autopairs_status, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_status then
	return
end

require("nvim-autopairs").setup({
	check_ts = true, -- enable treesitter
	ts_config = {
		lua = { "string" },
		javascript = { "template_string" },
	},
})
