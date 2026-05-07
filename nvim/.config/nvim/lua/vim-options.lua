-- Other VIM commands
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set nu")
vim.cmd("set cursorline")

-- F9 : run `build.sh`
vim.api.nvim_set_keymap('n', '<F9>', ':w<CR>:!sh build.sh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<F9>', '<Esc>:w<CR>:!sh build.sh<CR>', { noremap = true, silent = true })

-- Copy to Clipboard 
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Y', '"+yg_', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', { noremap = true, silent = true })
-- Paste from clipboard
-- nnoremap <leader>p "+p
-- nnoremap <leader>P "+P
-- vnoremap <leader>p "+p
-- vnoremap <leader>P "+P
