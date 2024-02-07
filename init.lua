require("core.plugins")
require("core.keymaps")

require("core.plugin_config.onedark")
require("core.plugin_config.lualine")
require("core.plugin_config.nvim-tree")
require("core.plugin_config.telescope")
require("core.plugin_config.treesitter")
require("core.plugin_config.lsp")

require('onedark').setup {
	--'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' 
    style = 'darker', 
	transparent = true
}

require('onedark').load()

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

