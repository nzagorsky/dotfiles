
vim.cmd(
    [[
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
syntax on
filetype indent on
filetype plugin on
filetype plugin indent on " Enable filetype plugins and indention

set completeopt-=preview
set lazyredraw
set scrolloff=1
set textwidth=0  " Do not break the line while typing
set showcmd " Show the (partial) command as it’s being typed
set nostartofline " Don’t reset cursor to start of line when moving around.

set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set incsearch
set hlsearch
set ignorecase
set smartcase
set infercase
set showmatch

set splitbelow
set splitright

set wildmenu

set foldenable
set foldmethod=indent
set foldlevelstart=99
set foldnestmax=10 " deepest fold is 10 levels

set noerrorbells  " No annoying errors
set novisualbell

set updatetime=250  

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
    ]]
    )
