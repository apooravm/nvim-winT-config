local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<Leader>ps', builtin.live_grep, {})

