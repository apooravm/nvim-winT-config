local builtin = require("telescope.builtin")
local telescope = require("telescope")

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules/.*",
			".git/.*",
			"vendor/.*",
		},
		-- finder_command = { "--no-ignore", "!.git" },
		-- no_ignore = true,
	},
	-- additional_args = function(args)
	-- 	return vim.list_extend(args, { "--hidden", "--no-ignore" })
	-- end,
})

-- Both '<Leader>pf' and 'Enter Key' will bring up the find_files menu
vim.keymap.set("n", "<Leader>pf", builtin.find_files, {})
-- Search the files ignored by normal search
vim.keymap.set("n", "<Leader>pd", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", {})
vim.keymap.set("n", "<CR>", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<Leader>ps", builtin.live_grep, {})
