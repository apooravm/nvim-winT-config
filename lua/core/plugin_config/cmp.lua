local cmp = require("cmp")
local cmp_format = require("lsp-zero").cmp_format()
local cmp_action = require("lsp-zero").cmp_action()
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

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
	},
	mapping = cmp.mapping.preset.insert({
		-- Press enter to confirm completion
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		-- Tab will trigger completion menu. If menu open, tab will navigate to the next item
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
	},
	--- (Optional) Show source name in completion menu
	-- formatting = cmp_format,
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = lspkind.cmp_format({
			mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			maxwidth = 50, -- prevent the popup from showing more than provided characters
			ellipsis_char = "...",
			show_labelDetails = true,
			before = function(entry, vim_item)
				-- vim_item = formatForTailwindCSS(entry, vim_item) -- for tailwind css autocomplete
				-- local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
				-- local strings = vim.split(kind.kind, "%s", { trimempty = true })
				-- kind.kind = " " .. (strings[1] or "") .. " "
				-- kind.menu = "    (" .. (strings[2] or "") .. ")"
				--
				-- return kind
				vim_item.menu = "(" .. vim_item.kind .. ")"
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
			side_padding = 2,
		}),
		documentation = cmp.config.window.bordered({
			-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
			border = "rounded",
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
