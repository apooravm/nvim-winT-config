-- removed the need for lspkind or any icon packs
-- changed the formatter func in cmp
-- added squared corners

local cmp = require("cmp")
local luasnip = require("luasnip")

local mini_icons_pack = {
	Text = { glyph = "" },
	Method = { glyph = "" },
	Function = { glyph = "" },
	Constructor = { glyph = "" },
	Field = { glyph = "" },
	Variable = { glyph = "" },
	Class = { glyph = "" },
	Interface = { glyph = "" },
	Module = { glyph = "" },
	Property = { glyph = "" },
	Unit = { glyph = "" },
	Value = { glyph = "" },
	Enum = { glyph = "" },
	Keyword = { glyph = "" },
	Snippet = { glyph = "" },
	Color = { glyph = "" },
	File = { glyph = "" },
	Reference = { glyph = "" },
	Folder = { glyph = "" },
	EnumMember = { glyph = "" },
	Constant = { glyph = "" },
	Struct = { glyph = "" },
	Event = { glyph = "" },
	Operator = { glyph = "" },
	TypeParameter = { glyph = "" },
}

local vscode_symbol_map = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "",
}

-- Load vscode-style snippets lazily
require("luasnip.loaders.from_vscode").lazy_load()

-- TailwindCSS color formatting
local function format_tailwind(entry, item)
	if item.kind == "Color" and entry.completion_item.documentation then
		local _, _, r, g, b = entry.completion_item.documentation:find("^rgb%((%d+), (%d+), (%d+)")
		if r then
			local hex = string.format("%02x%02x%02x", r, g, b)
			local group = "Tw_" .. hex

			if vim.fn.hlID(group) < 1 then
				vim.api.nvim_set_hl(0, group, { fg = "#" .. hex })
			end

			item.kind = "⬤"
			item.kind_hl_group = group
		end
	end
	return item
end

local maxwidth = 30
local ellipsis_char = "..."

local function truncate(str, width)
	if #str > width then
		return str:sub(1, width - #ellipsis_char) .. ellipsis_char
	end
	return str
end

local function cmp_formatter(entry, item)
	-- 1️⃣ Add icon in text_symbol mode (kind + glyph)
	local icon = vscode_symbol_map[item.kind]
	-- temp stores the type of the item - function, object, var, etc
	local temp = item.kind
	if icon then
		item.kind = icon .. " "
	else
		item.kind = " " -- fallback empty space
	end

	-- 2️⃣ Truncate the completion text if too long
	item.abbr = truncate(item.abbr, maxwidth)

	-- 3️⃣ Add menu label (source)
	-- item.menu = "[" .. entry.source.name .. "]"
	item.menu = temp

	-- 4️⃣ Optional: Tailwind CSS colors (keep your existing function)
	if item.kind:find("Color") then
		item = format_tailwind(entry, item)
	end

	return item
end

cmp.setup({
	preselect = cmp.PreselectMode.Item,

	completion = {
		completeopt = "menu,menuone,noinsert",
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),

		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(),
	}),

	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
	},

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = cmp_formatter,
	},

	window = {
		completion = cmp.config.window.bordered({
			col_offset = 0,
			side_padding = 1,
			-- topleft, top, topright, right, bottomright, bottom, bottomleft, left
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		}),
		documentation = cmp.config.window.bordered({
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		}),
	},
})

vim.opt.pumblend = 0
