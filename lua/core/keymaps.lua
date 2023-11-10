-- Enable relative line numbering
vim.wo.relativenumber = true
vim.wo.number = true

-- Enable autoindent
vim.o.autoindent = true

-- Set tab options
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.softtabstop = 4

-- Enable mouse support
vim.o.mouse = 'a'

-- Other
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true

-- Set <Ctrl> as the leader key
-- vim.g.mapleader = '<Ctrl>'

-- Map <Leader>p to paste from system clipboard
vim.api.nvim_set_keymap('n', '<Leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>p', '"+y', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<A-S-Down>', ':t.<CR>', { noremap = true, silent = true })

