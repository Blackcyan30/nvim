vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('talha-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- -- Highlight @param, @return, etc. in comments using Vim regex-based highlighting
-- vim.cmd [[syntax match DocTag /@\w\+/ containedin=ALL]]
-- vim.cmd [[highlight link DocTag Keyword]]

-- -- Setup doc comment tag highlighting
-- require('talha.doccomment_tags').setup() 