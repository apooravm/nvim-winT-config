require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "rust", "vim", "python", "go", "javascript", "typescript", "svelte" },

	-- Install Parsers synchronously
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	-- Auto indent when moving to the next line. Say pressing 'o' moves you down a line and auto indents as well
	indent = { enable = true, disable = { "yaml", "go" } },
})
