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

-- Dont highlight searches with '/'?
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- when scrolling with cursor, always has 8lines. Cursor doesnt hug the start/end
vim.opt.scrolloff = 8

vim.opt.updatetime = 50

-- Enable mouse support
vim.o.mouse = "a"

-- Other
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set <Ctrl> as the leader key
-- vim.g.mapleader = '<Ctrl>'

-- Map <Leader>p to paste from system clipboard
vim.api.nvim_set_keymap("n", "<Leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Leader>p", '"+y', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<A-S-Down>", ":t.<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- nvim-tree
vim.g.loaded_newtw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<c-m>", ":NvimTreeFocus<CR>")

-- Move lines of code around with K, J
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 'space+l' to show a dialog box containing the error. Useful for when the error line is too long
-- vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- space + s on some word selects same words in the file and allows to edit them
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- :%s/\(.\)

--^ Remap CTRL-` to switch between files
-- vim.api.nvim_set_keymap('n', '<C-^>', '<C-`>', { noremap = true, silent = true })
