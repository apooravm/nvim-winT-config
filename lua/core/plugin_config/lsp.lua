local lsp_zero = require("lsp-zero")

lsp_zero.set_sign_icons({
	error = "✘",
	warn = "▲",
	hint = "⚑",
	info = "»",
})

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	-- lsp_zero.default_keymaps({buffer = bufnr})
	-- local opts = {buffer = bufnr, remap = false}
	--
	-- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("i", "<C>k", function()
		vim.lsp.buf.hover()
	end, opts)
	-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	-- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	-- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	-- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	-- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

	-- lsp_zero.buffer_autoformat()
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		callback = function(args)
			require("conform").format({ bufnr = args.buf })
		end,
	})
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- here you can setup the language servers
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"rust_analyzer",
		"pylsp",
		"clangd",
		"gopls",
		"eslint",
		"svelte",
		"lua_ls",
		"tailwindcss",
	},
	handlers = {
		lsp_zero.default_setup,
	},
})
