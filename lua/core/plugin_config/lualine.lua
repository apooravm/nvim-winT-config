local custom_horizon = require'lualine.themes.horizon'

custom_horizon.normal.a.bg = 'b6fc03'
custom_horizon.command.a.bg = 'f76a05'
custom_horizon.visual.a.bg = '8726eb'

local function custom_time_component()
	return os.date("%H:%M")
end

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = custom_horizon,
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {{'filename', path=1}},
    lualine_x = {'fileformat', 'filetype', { custom_time_component }},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
