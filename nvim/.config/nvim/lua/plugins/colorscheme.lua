-- Colorscheme
return {
  "navarasu/onedark.nvim",
  name = "onedark",
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "darker"
    })
    vim.cmd.colorscheme("onedark")
  end
}
