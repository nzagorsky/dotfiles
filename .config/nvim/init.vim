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


" Install Vim Plug.
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif


" Quickly edit and source vimrc, udpating all buffers.
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC <bar> bufdo e<CR>

"-------------------------------------------------------------------------------
" Good practicies
"-------------------------------------------------------------------------------

" Force usage of <jj>
inoremap <Esc> <Nop>
" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Utility.
Plug 'vim-airline/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'

" Colors.
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'

" Files navigation.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'

" Distration-free mode
Plug 'junegunn/goyo.vim'

" Code check.
Plug 'neomake/neomake'

" Auto complete.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript.jsx', 'do': 'sudo npm install -g tern' }
Plug 'raimondi/delimitmate'

" Routine automation.
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

" Git integration.
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax.
Plug 'sheerun/vim-polyglot'  " Syntax highlightning for all languages.
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

" Python modules.
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'python-rope/ropevim', { 'for': 'python' }
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

" JS
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript.jsx '}

"Nim
Plug 'baabelfish/nvim-nim', { 'for': 'nim' }

" Go
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'zchee/deoplete-go', {'do': ['make', 'go get -u github.com/nsf/gocode'], 'for': 'go'}

" Rust
Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'}

" Vim
Plug 'Shougo/neco-vim', {'for': 'vim'}

" Relative numbers when it makes sense
Plug 'jeffkreeftmeijer/vim-numbertoggle'

call plug#end()


" ------------------------------------------------------------------------------
" Key bindings
" ------------------------------------------------------------------------------

let mapleader = "\<Space>"

noremap <F3> :Autoformat<CR>

" FZF keybindings.
nnoremap <leader>a :Ag<Space>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>l :BLines<CR>
nnoremap <leader>h :Helptags<CR>
nnoremap <C-p> :Files<CR>

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

"" Airline
let g:airline_theme='tomorrow'
let g:airline_left_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_right_sep=''
let g:airline_section_warning=''  
let g:airline_section_y='' 
let g:airline_section_z=''

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.branch = 'br:'
let g:airline_symbols.readonly = 'RO'
let g:airline_symbols.linenr = 'LN' 

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''



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
nnoremap <C-e> :Dirvish<CR>
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
