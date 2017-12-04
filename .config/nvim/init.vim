" ------------------------------------------------------------------------------
" Basic settings.
" ------------------------------------------------------------------------------

" use vim settings, rather than vi settings
" must be first, because it changes other options as a side effect
set nocompatible

" Optimize for fast terminal connections
set ttyfast

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard+=unnamedplus

" hide buffers, not close them
set hidden

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undo

" Move Backup Files to ~/.vim/sessions
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions
:silent call system('mkdir -p ' . &undodir)
:silent call system('mkdir -p ' . &dir)

set noswapfile

" enable automatic title setting for terminals
set title
set titleold="Terminal"
set titlestring=%F

" Quickly edit and source vimrc, udpating all buffers.
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC <bar> bufdo e<CR>
nnoremap geft :Dirvish ~/.vim/ftplugin<CR>

"-------------------------------------------------------------------------------
" Good practicies
"-------------------------------------------------------------------------------

" Force usage of <jj>
inoremap <Esc> <Nop>

" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------
" Setup dein
if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
endif
set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/

" Setup plugins
if dein#load_state(expand('~/.config/nvim'))
    call dein#begin(expand('~/.config/nvim'))

    " Manage dein
    call dein#add('Shougo/dein.vim')

    " Utility.
    call dein#add('christoomey/vim-tmux-navigator')

    " Colors.
    call dein#add('chriskempson/base16-vim')

    " Files navigation.
    call dein#add('junegunn/fzf', { 'merged': 0, 'build': './install --bin' })
    call dein#add('junegunn/fzf.vim')
    call dein#add('justinmk/vim-dirvish')

    " Code check.
    call dein#add('neomake/neomake')

    " Auto complete.
    call dein#add('Shougo/deoplete.nvim', { 'build': ':UpdateRemotePlugins' })
    call dein#add('raimondi/delimitmate')

    " Routine automation.
    call dein#add('Chiel92/vim-autoformat')
    call dein#add('tpope/vim-surround')
    call dein#add('ervandew/supertab')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-commentary')

    " Async command execution
    call dein#add('skywind3000/asyncrun.vim')

    " Git integration.
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    " Syntax highlightning for all languages.
    call dein#add('sheerun/vim-polyglot')

    " Relative numbers when it makes sense
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')

    " Snippets
    call dein#add('SirVer/ultisnips')

    " Python modules.
    call dein#add('nvie/vim-flake8', { 'on_ft': 'python' })
    call dein#add('zchee/deoplete-jedi', { 'on_ft': 'python' })
    call dein#add('davidhalter/jedi-vim', { 'on_ft': 'python' })
    call dein#add('python-rope/ropevim', { 'on_ft': 'python' })
    call dein#add('raimon49/requirements.txt.vim', {'on_ft': 'requirements'})
    call dein#add('Vimjas/vim-python-pep8-indent', { 'on_ft': 'python' })

    " JS
    call dein#add('elzr/vim-json', { 'on_ft': 'json' })
    call dein#add('pangloss/vim-javascript', { 'on_ft': 'javascript.jsx' })
    call dein#add('mxw/vim-jsx', { 'on_ft': 'javascript.jsx' })

    "Nim
    call dein#add('baabelfish/nvim-nim', { 'on_ft': 'nim' })

    " Go
    call dein#add('zchee/deoplete-go', {'build': ['make', 'go get -u github.com/nsf/gocode'], 'on_ft': 'go'})
    call dein#add('fatih/vim-go', { 'hook_post_update': ':GoInstallBinaries', 'on_ft': 'go' })

    " Rust
    call dein#add('sebastianmarkow/deoplete-rust', {'on_ft': 'rust'})

    " Vim
    call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})

    if dein#check_install()
      call dein#install()
      let pluginsExist=1
    endif

    call dein#end()

endif


" ------------------------------------------------------------------------------
" Key bindings
" ------------------------------------------------------------------------------

let mapleader = "\<Space>"

noremap <F3> :Autoformat<CR>

" FZF keybindings.
nnoremap <C-p> :Files<CR>
nnoremap <leader>a :Ag<Space>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>h :Helptags<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>T :AsyncRun ctags -R .<CR> :echo "Tags generated"<CR>

" Thank you vi
nnoremap Y y$

" Exit insert mode by pressing <jj>
inoremap jj <Esc>

" pretty much essential: by default in terminal mode, you have
" to press ctrl-\-n to get into normal mode ain't nobody got time for that.
tnoremap <Esc> <C-\><C-n>

" Save on <leader>w
nnoremap <Leader>w :w<CR>

" Quit window on <leader>q
nnoremap <leader>q :q<CR>

nmap <Leader><Leader> V
map q: :q

" Remove trailing whitespaces
nnoremap<leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" arrow keys move visible lines
inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
nnoremap <Down> gj
nnoremap <Up> gk

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

"" Tabs
nnoremap <silent> <S-t> :tab split<CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/"<CR><CR>


" <Enter> in normal mode will disable highlighting of current search.
" Note: it will not clear the search, so using <n> will jump to the next
" occurance and enable search highlighting back
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" ------------------------------------------------------------------------------
" Plugins setup.
" ------------------------------------------------------------------------------

"" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 0



"" Gitgutter
let g:gitgutter_realtime = 1


"" Fugitive git.
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>


"" Neomake
autocmd! BufWritePost,BufEnter * Neomake " Run NeoMake on read and write operations


"" Supertab
" let g:SuperTabDefaultCompletionType = "<C-X><C-O>"


" Vim number toggle
set number relativenumber

"" Dirvish
nnoremap <C-e> :Dirvish %<CR>
let g:dirvish_mode = ':sort ,^.*[\/],'

" ------------------------------------------------------------------------------
" Editor setup
" ------------------------------------------------------------------------------

" Color setup
set background=dark
let base16colorspace=256
colorscheme base16-ocean
" set termguicolors " if you want to run vim in a terminal
syntax on

filetype indent on
filetype plugin on
filetype plugin indent on " Enable filetype plugins and indention
set autoindent " enable auto indentation

set scrolloff=3 " keep some more lines for scope
set laststatus=2

set smarttab
set tabstop=4
"
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set softtabstop=4

"omnicompletion settings
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
set number " Numbers

set nostartofline " Don’t reset cursor to start of line when moving around.
set showcmd " Show the (partial) command as it’s being typed

" Search settings
set incsearch
set hlsearch
set ignorecase
set smartcase
set infercase

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set ai " auto indent
set wrap " wrap lines

set cursorline
set wildmenu
set lazyredraw
set showmatch

set foldenable
set foldmethod=indent
set foldlevel=99
set noerrorbells " No annoying errors
set novisualbell


set updatetime=250  


if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
