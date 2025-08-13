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
	-- https://lsp-zero.netlify.app/v3.x/reference/lua-api.html#lsp-actions
	-- https://lsp-zero.netlify.app/v3.x/reference/lua-api.html#lsp-actions
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

	-- format code on keypress
	vim.keymap.set("n", "<leader>]", function()
		vim.lsp.buf.format()
	end, opts)

	-- Trigger suggested code actions. Like import something or change type etc.
	vim.keymap.set("n", "<leader>\\", function()
		vim.lsp.buf.code_action()
	end, opts)

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
-- mason => package manager for nvim
-- mason-lspconfig => extension to mason.nvim, makes it easier to use lspconfig with mason.nvim
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		-- tsserver name changed to ts_ls
		-- Reason for "tsserver not a valid entry in ensure_installed" error
		"ts_ls",
		"rust_analyzer",
		-- "pylsp",
		-- "ruff",
		"pyright",
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

-- refer
-- https://docs.astral.sh/ruff/editors/setup/#neovim
-- disabling formatting via pyright to allow through ruff
-- require("lspconfig").pyright.setup({
-- 	settings = {
-- 		pyright = {
-- 			disableOrganizeImports = true,
-- 		},
-- 		python = {
-- 			analysis = {
-- 				ignore = { "*" },
-- 			},
-- 		},
-- 	},
-- })
