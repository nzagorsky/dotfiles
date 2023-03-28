local vim = vim
local g = vim.g
local o = vim.o
local set = vim.opt
local vapi = vim.api

set.lazyredraw = true
set.scrolloff = 1
set.textwidth = 0 -- Do not break the line while typing
set.showcmd = true -- Show the (partial) command as it’s being typed

set.smarttab = true
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4

set.incsearch = true
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.infercase = true
set.showmatch = true

set.splitbelow = true
set.splitright = true

set.wildmenu = true

set.foldenable = true
set.foldmethod = "indent"
set.foldlevelstart = 99
set.foldnestmax = 10 -- deepest fold is 10 levels

vim.cmd [[
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
syntax on
filetype indent on
filetype plugin on
filetype plugin indent on " Enable filetype plugins and indention

set nostartofline " Don’t reset cursor to start of line when moving around.

set noerrorbells " No annoying errors
set novisualbell


function! MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

" Creating parent folders if they doesn't exist on buffer save.
augroup AutomaticDirectoryCreation
    autocmd!
    autocmd BufWritePre * :call MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


    ]]

-- Settings
o.clipboard = "unnamedplus"
o.autoread = true -- detect when a file is changed
o.signcolumn = "yes" --  no more text shifting
o.hidden = true --  buffers
o.wrap = true
o.swapfile = true
o.undofile = true
o.undodir = vim.fn.expand "~" .. "/.cache/nvim/undo"
o.backupdir = vim.fn.expand "~" .. "/.cache/nvim/backup"
o.directory = vim.fn.expand "~" .. "/.cache/nvim/dir"
o.history = 1000
o.title = true
o.titleold = "Terminal"
o.titlestring = "%F"
o.cmdheight = 2
o.shortmess = "aoOtIWcFs"
o.updatetime = 250

g.mapleader = " "

vapi.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true })
vapi.nvim_set_keymap("c", "jk", "<Esc>", { noremap = true })
vapi.nvim_set_keymap("t", "jk", [[<C-\><C-n>]], { noremap = true })

vapi.nvim_set_keymap("i", "ол", "<Esc>", { noremap = true })
vapi.nvim_set_keymap("c", "ол", "<Esc>", { noremap = true })
vapi.nvim_set_keymap("t", "ол", [[<C-\><C-n>]], { noremap = true })

vapi.nvim_set_keymap("n", "j", "gj", {})
vapi.nvim_set_keymap("n", "k", "gk", {})

vapi.nvim_set_keymap("n", "<leader><leader>", "V", { noremap = true })
vapi.nvim_set_keymap("n", "<leader>w", ":w<cr>", { noremap = true })
vapi.nvim_set_keymap("n", "<leader>q", ":q<cr>", { noremap = true })
vapi.nvim_set_keymap("n", "<leader>kb", ":bd<cr>", { noremap = true })
vapi.nvim_set_keymap("n", "Y", "y$", { noremap = true })

vapi.nvim_set_keymap("n", "<c-n>", ":NvimTreeToggle<cr>", { noremap = true })
vapi.nvim_set_keymap("n", "<a-x>", ":Commands<cr>", { noremap = true })

vapi.nvim_set_keymap("n", "<c-h>", "<C-w>h", { noremap = true })
vapi.nvim_set_keymap("n", "<c-j>", "<C-w>j", { noremap = true })
vapi.nvim_set_keymap("n", "<c-k>", "<C-w>k", { noremap = true })
vapi.nvim_set_keymap("n", "<c-l>", "<C-w>l", { noremap = true })

vapi.nvim_set_keymap("t", "<c-h>", [[<C-\><C-n><C-w>h]], { noremap = true })
vapi.nvim_set_keymap("t", "<c-j>", [[<C-\><C-n><C-w>j]], { noremap = true })
vapi.nvim_set_keymap("t", "<c-k>", [[<C-\><C-n><C-w>k]], { noremap = true })
vapi.nvim_set_keymap("t", "<c-l>", [[<C-\><C-n><C-w>l]], { noremap = true })

vapi.nvim_set_keymap("n", "<s-t>", ":tab split<cr>", { noremap = true, silent = true })
vapi.nvim_set_keymap("n", "<c-t>", ":tabnew<cr>", { noremap = true, silent = true })
vapi.nvim_set_keymap("n", "<cr>", ":nohlsearch<cr><cr>", { noremap = true, silent = true })

vapi.nvim_set_keymap("n", "<leader>S", [[:%s/\s\+$//<cr>:let @/=''<CR>]], { noremap = true, silent = true })

vapi.nvim_set_keymap("c", "w!!", "w !sudo tee % > /dev/null", {})

vapi.nvim_set_keymap("n", "gev", ":e $MYVIMRC<cr>", { noremap = true })
vapi.nvim_set_keymap("n", "gsv", ":so $MYVIMRC <bar> bufdo e<CR>", { noremap = true })

if os.getenv "TMUX" == nil then
  for num = 1, 10 do
    vapi.nvim_set_keymap("n", string.format("<A-%s>", num), string.format("<Esc>%sgt", num), { noremap = true })
  end

  for num = 1, 10 do
    vapi.nvim_set_keymap("i", string.format("<A-%s>", num), string.format("<Esc>%sgt", num), { noremap = true })
  end

  for num = 1, 10 do
    vapi.nvim_set_keymap("t", string.format("<A-%s>", num), string.format([[<C-\><C-n>%sgt]], num), { noremap = true })
  end

  vapi.nvim_set_keymap("n", "<A-h>", "<Esc>:tabprevious<CR>", { noremap = true })
  vapi.nvim_set_keymap("i", "<A-h>", "<Esc>:tabprevious<CR>", { noremap = true })
  vapi.nvim_set_keymap("t", "<A-h>", [[<C-\><C-n>:tabprevious<CR>]], { noremap = true })

  vapi.nvim_set_keymap("n", "<A-l>", "<Esc>:tabnext<CR>", { noremap = true })
  vapi.nvim_set_keymap("i", "<A-l>", "<Esc>:tabnext<CR>", { noremap = true })
  vapi.nvim_set_keymap("t", "<A-l>", [[<C-\><C-n>:tabnext<CR>]], { noremap = true })
end
