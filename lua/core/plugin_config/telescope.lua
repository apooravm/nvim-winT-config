local builtin = require('telescope.builtin')

-- Both '<Leader>pf' and 'Enter Key' will bring up the find_files menu
vim.keymap.set('n', '<Leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<CR>', builtin.find_files, {})

vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<Leader>ps', builtin.live_grep, {})

