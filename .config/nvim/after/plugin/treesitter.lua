require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"c",
		"bash",
		"comment",
		"css",
		"diff",
		"dockerfile",
		"git_rebase",
		"gitattributes",
		"gitignore",
		"go",
		"gomod",
		"html",
		"http",
		"java",
		"javascript",
		"jq",
		"jsdoc",
		"json",
		"json5",
		"jsonc",
		"jsonnet",
		"lua",
		"make",
		"markdown",
		"markdown_inline",
		"python",
		"regex",
		"scss",
		"sql",
		"terraform",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	indent = { enable = true },
	autotag = { enable = true },
})
