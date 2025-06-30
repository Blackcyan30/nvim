require("talha.core")
require("talha.lazy")

-- Always set custom line number colors, regardless of colorscheme or plugin
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  pattern = "*",
  callback = function()
    vim.cmd [[
      highlight! LineNr guifg=#FFD700
      highlight! LineNrAbove guifg=#FFD700
      highlight! LineNrBelow guifg=#FFD700
      highlight! CursorLineNr guifg=#FF4500 gui=bold
    ]]
  end,
})
