require("core.plugins")
require("core.keymaps")

-- require("core.plugin_config.onedark")
-- require("core.plugin_config.lualine")
-- require("core.plugin_config.nvim-tree")
-- require("core.plugin_config.telescope")
-- require("core.plugin_config.treesitter")
-- require("core.plugin_config.lsp")
-- require("core.plugin_config.comment")
require("core.plugin_config.init")

-- require("luasnip.loaders.from_vscode").lazy_load({ include = { "python" } })

require("onedark").setup({
	--'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
	style = "darker",
	transparent = true,
	highlights = {
		["CursorLineNr"] = { fg = "#ff77a2" },
	},

	-- cmp_itemkind_reverse = true,
})

require("onedark").load()
-- require('oneokai').setup {
--     style = 'darker'
-- }
-- require('oneokai').load()

-- require("catppuccin").setup({
-- 	flavour = "frappe",
-- 	transparent_background = false
-- })
--
-- vim.cmd.colorscheme "catppuccin"

-- vim.cmd('TSEnable highlight')
-- Transparent baackground
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- removes those border colouring
-- https://www.reddit.com/r/neovim/comments/18faftd/cmp_border_background_is_changed_all_of_a_sudden/
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })

-- Experimental
-- Select item from quickfix list window
vim.api.nvim_set_keymap("n", "cn<CR>", "<Leader>p", { noremap = true, silent = true })
