vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift


-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamed") -- use system clipboard as default register (more compatible with macOS)

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Faster cursor movement when holding keys
opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (default 1000)
opt.ttimeoutlen = 50 -- Time to wait for a key code sequence to complete (default -1)

-- Faster scrolling
opt.scrolloff = 10 -- Keep 10 lines above/below cursor when scrolling
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor when scrolling

-- Even faster cursor movement
opt.timeout = false -- Disable timeout for key sequences
opt.ttimeout = false -- Disable timeout for terminal key codes
