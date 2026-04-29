-- init.lua : alex-fddz | ascii font : Script

--     _                       , __                                      
--  \_|_)                     /|/  \                                     
--    |     __,   __           | __/ __   __ _|_  , _|_  ,_    __,    _  
--   _|    /  |  / / _|   |    |   \/  \_/  \_|  / \_|  /  |  /  |  |/ \_
--  (/\___/\_/|_/ /_/  \_/|/   |(__/\__/ \__/ |_/ \/ |_/   |_/\_/|_/|__/ 
--                 /|    /|                                        /|    
--                 \|    \|                                        \|

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
                         
--     _                                              
--  \_|_)                       ()                    
--    |     __,   __            /\  _ _|_          _  
--   _|    /  |  / / _|   |    /  \|/  |  |   |  |/ \_
--  (/\___/\_/|_/ /_/  \_/|/  /(__/|__/|_/ \_/|_/|__/ 
--                 /|    /|                     /|    
--                 \|    \|                     \|    

local plugins = {
  { "navarasu/onedark.nvim", name = "onedark", priority = 1000 }, 
  { "nvim-telescope/telescope.nvim", tag = "0.1.6", 
      dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  { "nvim-tree/nvim-tree.lua", version = "*", lazy = false, 
      dependencies = { "nvim-tree/nvim-web-devicons" } },
  { 'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' } }
}
local opts = {}
require("lazy").setup(plugins, opts)

--   , __  _                             
--  /|/  \| |             o              
--   |___/| |         __,     _  _    ,  
--   |    |/  |   |  /  | |  / |/ |  / \_
--   |    |__/ \_/|_/\_/|/|_/  |  |_/ \/ 
--                     /|                
--                     \|

-- Colorscheme
require("onedark").setup({ style = 'darker' })
require("onedark").load()

-- Telescope: fuzzy finding
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- Treesitter: better syntax highlighting, indentation, folding...
local ts_configs = require("nvim-treesitter.configs")
ts_configs.setup({
  ensure_installed = { "c", "cmake", "cpp", "diff", "json", "python", 
                       "bash", "lua", "vim", "vimdoc", "html", "css",
                       "yang", "yaml", "arduino" },
  highlight = { enable = true },
  indent = { enable = true }  
})

-- Nvim-tree: side panel / file explorer
require("nvim-tree").setup()
vim.keymap.set({'n','i','v'}, '<leader>e', ':NvimTreeToggle<CR>')

-- Lualine: status line
require("lualine").setup({ options = { theme = "onedark" } })

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
-- " " Paste from clipboard
-- nnoremap <leader>p "+p
-- nnoremap <leader>P "+P
-- vnoremap <leader>p "+p
-- vnoremap <leader>P "+P

