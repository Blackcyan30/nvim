vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('talha-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Detect changes written by another program (for example, an external patch).
-- `autoread` reloads only an unmodified buffer. If the buffer has local edits,
-- Neovim shows its normal FileChangedShell prompt instead of overwriting them.
vim.opt.autoread = true
vim.opt.updatetime = 250
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  desc = 'Check for files changed outside Neovim',
  group = vim.api.nvim_create_augroup('talha-checktime', { clear = true }),
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd('checktime')
    end
  end,
})

-- -- Highlight @param, @return, etc. in comments using Vim regex-based highlighting
-- vim.cmd [[syntax match DocTag /@\w\+/ containedin=ALL]]
-- vim.cmd [[highlight link DocTag Keyword]]

-- -- Setup doc comment tag highlighting
-- require('talha.doccomment_tags').setup() 
