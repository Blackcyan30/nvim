-- TODO: I need to make it so that commenting is <leader> cc


return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- enable comment
    comment.setup({
      -- for commenting tsx, jsx, svelte, html files
      pre_hook = ts_context_commentstring.create_pre_hook(),
      -- Disable default keymaps (gc, gb)
      mappings = {
        basic = false,
        extra = false,
      },
    })

    -- Keymaps for commenting
    local api = require('Comment.api')
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true, desc = "Toggle line comment" }
    keymap({ 'n', 'x' }, '<leader>cc', function()
      if vim.fn.mode() == 'n' then
        api.toggle.linewise.current()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
        api.toggle.linewise(vim.fn.visualmode())
      end
    end, opts)
    keymap({ 'n', 'x' }, '<leader>cb', function()
      if vim.fn.mode() == 'n' then
        api.toggle.blockwise.current()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
        api.toggle.blockwise(vim.fn.visualmode())
      end
    end, { noremap = true, silent = true, desc = "Toggle block comment" })
  end,
}
