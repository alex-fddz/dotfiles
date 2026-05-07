-- Treesitter: better syntax highlighting, indentation, folding...
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        "c", "cmake", "cpp", "diff", "json", "python", 
        "bash", "lua", "vim", "vimdoc", "html", "css",
        "yang", "yaml", "arduino"
      },
      highlight = { enable = true },
      indent = { enable = true }  
    })
  end
}
