local g = vim.g
local o = vim.o

-- mappings.lua
require('core.mappings')

-- statusline.lua
require('core.statusline')

-- settings.lua
require('core.settings')

-- utils.lua
require('core.utils')

-- Settings
o.clipboard = 'unnamedplus'
o.autoread = true    -- detect when a file is changed
o.signcolumn = 'yes' --  no more text shifting
o.hidden = true      --  buffers
o.wrap = true
o.swapfile = true
o.undofile = true
o.undodir = vim.fn.expand('~') .. '/.cache/nvim/undo'
o.backupdir = vim.fn.expand('~') .. '/.cache/nvim/backup'
o.directory = vim.fn.expand('~') .. '/.cache/nvim/dir'
o.history = 1000
o.title = true
o.titleold = "Terminal"
o.titlestring = "%F"
o.cmdheight = 2
o.shortmess = "aoOtIWcFs"
