require 'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "lua", "rust", "vim", "python", "go", "javascript"},
	
	-- Install Parsers synchronously
	sync_install = false,
	auto_install = true,
	highlights = {
		enable = true
	},
}
