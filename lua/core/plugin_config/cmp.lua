local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format()
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
	-- Preselect the first item in the completion menu
	preselect = 'item',
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	mapping = cmp.mapping.preset.insert({
		-- Press enter to confirm completion
		['<CR>'] = cmp.mapping.confirm({select = true}),
		-- Tab will trigger completion menu. If menu open, tab will navigate to the next item
		['<Tab>'] = cmp_action.tab_complete(),
		['<S-Tab>'] = cmp_action.select_prev_or_fallback(),

	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'luasnip' },
	},
	--- (Optional) Show source name in completion menu
	formatting = cmp_format,

	-- adds borders to the completion menu
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
})

vim.opt.pumblend = 0

