-- https://lsp-zero.netlify.app/v3.x/autocomplete.html
-- Responsible for autocompletion

local cmp = require("cmp")
local cmp_format = require("lsp-zero").cmp_format()
local cmp_action = require("lsp-zero").cmp_action()
local lspkind = require("lspkind")

-- require('luasnip.loaders.from_vscode').lazy_load()
-- require("luasnip.loaders.from_vscode").load {}
require("luasnip/loaders/from_vscode").lazy_load()

local cmp_kinds = {
	Text = "  ",
	Method = "  ",
	Function = "  ",
	Constructor = "  ",
	Field = "  ",
	Variable = "  ",
	Class = "  ",
	Interface = "  ",
	Module = "  ",
	Property = "  ",
	Unit = "  ",
	Value = "  ",
	Enum = "  ",
	Keyword = "  ",
	Snippet = "  ",
	Color = "  ",
	File = "  ",
	Reference = "  ",
	Folder = "  ",
	EnumMember = "  ",
	Constant = "  ",
	Struct = "  ",
	Event = "  ",
	Operator = "  ",
	TypeParameter = "  ",
}

-- https://www.reddit.com/r/neovim/comments/12l2fw6/sharing_my_neovim_config_the_product_of_countless/
-- https://www.reddit.com/r/neovim/comments/103zetf/how_can_i_get_a_vscodelike_tailwind_css/
local formatForTailwindCSS = function(entry, vim_item) -- for tailwindcss autocomplete
	if vim_item.kind == "Color" and entry.completion_item.documentation then
		local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
		if r then
			local colour = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
			local group = "Tw_" .. colour
			if vim.fn.hlID(group) < 1 then
				vim.api.nvim_set_hl(0, group, { fg = "#" .. colour })
			end
			vim_item.kind = "⬤" -- or "⬤" or "■" or anything
			vim_item.kind_hl_group = group
			return vim_item
		end
	end
	vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
	return vim_item
end

cmp.setup({
	-- Preselect the first item in the completion menu
	preselect = "item",
	completion = {
		completeopt = "menu,menuone,noinsert",

		-- trigger the completion menu automatically
		-- autocomplete = false,
	},
	mapping = cmp.mapping.preset.insert({
		-- Press enter to confirm completion
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		-- Supertab https://lsp-zero.netlify.app/v3.x/autocomplete.html#enable-super-tab
		-- Tab will trigger completion menu. If menu open, tab will navigate to the next item
		-- ["<Tab>"] = cmp_action.luasnip_supertab(),
		-- ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
		["<Tab>"] = cmp_action.tab_complete(),
		["<S-Tab>"] = cmp_action.select_prev_or_fallback(),

		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions. <C-Space> not work in windows terminal
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	--- (Optional) Show source name in completion menu
	-- formatting = cmp_format,
	-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-get-types-on-the-left-and-offset-the-menu
	-- https://www.reddit.com/r/neovim/comments/191eg59/how_to_achieve_cmp_ui_like_nvchad/
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format({
			mode = "text_symbol", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			maxwidth = 50, -- prevent the popup from showing more than provided characters
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
			show_labelDetails = true,
			-- menu = {
			-- 	buffer = "[Buffer]",
			-- 	nvim_lsp = "[LSP]",
			-- 	luasnip = "[LuaSnip]",
			-- 	nvim_lua = "[Lua]",
			-- 	latex_symbols = "[Latex]",
			-- },
			before = function(entry, vim_item)
				-- vim_item = formatForTailwindCSS(entry, vim_item) -- for tailwind css autocomplete
				-- local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
				-- local strings = vim.split(kind.kind, "%s", { trimempty = true })
				-- kind.kind = " " .. (strings[1] or "") .. " "
				-- kind.menu = "    (" .. (strings[2] or "") .. ")"
				--
				-- return kind
				vim_item.menu = "[" .. vim_item.kind .. "]"
				vim_item.dup = ({
					nvim_lsp = 0,
					path = 0,
				})[entry.source.name] or 0
				vim_item = formatForTailwindCSS(entry, vim_item) -- for tailwind css autocomplete
				return vim_item
			end,
		}),
	},

	-- adds borders to the completion menu
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
		completion = cmp.config.window.bordered({
			col_offset = 0, -- align the abbr and word on cursor (due to fields order below)
			side_padding = 1,
		}),
		documentation = cmp.config.window.bordered({
			-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
			-- border = "rounded",
		}),
	},
	-- window = {
	-- 	completion = {
	-- 		winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
	-- 		col_offset = -3,
	-- 		side_padding = 0,
	-- 	},
	-- },
})

vim.opt.pumblend = 0
