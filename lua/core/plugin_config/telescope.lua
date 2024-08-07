local builtin = require("telescope.builtin")
local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
			},
		},
		file_ignore_patterns = {
			"node_modules/.*",
			".git/.*",
			"vendor/.*",
		},
		layout_strategy = "vertical",
		layout_config = { height = 0.95, width = 0.6 },
		-- finder_command = { "--no-ignore", "!.git" },
		-- no_ignore = true,
	},
	pickers = {
		find_files = {
			-- theme = "dropdown",
		},
	},

	-- additional_args = function(args)
	-- 	return vim.list_extend(args, { "--hidden", "--no-ignore" })
	-- end,
})

-- https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#vim-pickers
-- Both '<Leader>pf' and 'Enter Key' will bring up the find_files menu
vim.keymap.set("n", "<Leader>pf", builtin.find_files, {})
-- Search the files ignored by normal search
vim.keymap.set("n", "<Leader>pd", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", {})
vim.keymap.set("n", "<CR>", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<Leader>ps", builtin.live_grep, {})
vim.keymap.set("n", "<Leader>o", builtin.buffers, {})
-- vim.keymap.set("n", "<Leader>pp", builtin.registers, {})

