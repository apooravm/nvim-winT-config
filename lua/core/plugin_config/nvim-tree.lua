vim.g.loaded_newtw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	view = {
		width = 25
	},
	hijack_cursor = false,
	renderer = {
		indent_markers = {
			enable = true,
		},
	},
})

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
vim.keymap.set('n', '<c-m>', ':NvimTreeFocus<CR>')
