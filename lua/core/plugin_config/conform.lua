require("conform").setup({
	format = {
		timeout_ms = 3000,
		async = false,
		quiet = false,
	},
	formatters = {
		-- ruff = {
		-- 	args = {
		-- 		"format",
		-- 		"--line-length",
		-- 		"88", -- Set your desired line length here
		-- 		"--force-exclude",
		-- 		"--stdin-filename",
		-- 		"$FILENAME",
		-- 		"-",
		-- 	},
		-- 	stdin = true,
		-- },
	},
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		-- python = { "isort", "black" },
		-- python = { "ruff" },
		-- Use a sub-list to run only the first available formatter

		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },

		rust = { "rustfmt" },
		go = { "gofmt" },
	},
})
