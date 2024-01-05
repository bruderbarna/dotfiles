local status, mason = pcall(require, "mason")
if not status then
	return
end

local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason.setup({})

lspconfig.setup({
	automatic_installation = true,
	ensure_installed = {
		"bashls",
		"dockerls",
		"eslint",
		"html",
		"jsonls",
		"tsserver",
	},
})

mason_null_ls.setup({
	automatic_installation = true,
	ensure_installed = {
		"prettierd",
		"eslint_d",
		"jq",
		"shellcheck",
	},
})
