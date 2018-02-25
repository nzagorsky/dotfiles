" ------------------------------------------------------------------------------
" Basic settings.
" ------------------------------------------------------------------------------
" use vim settings, rather than vi settings must be first, because it changes other options as a side effect
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

" Don't show the intro message when starting Vim
set shortmess=aoOtIWcFs

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
    if executable('tmux')
        call dein#add('christoomey/vim-tmux-navigator')
    endif

    " Zen mode
    call dein#add('junegunn/goyo.vim')

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
    call dein#add('tpope/vim-dispatch')

    " Git integration.
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    " Syntax highlightning for all languages.
    call dein#add('sheerun/vim-polyglot')

    " Python modules.
    call dein#add('nvie/vim-flake8', { 'on_ft': 'python' })
    call dein#add('zchee/deoplete-jedi', { 'on_ft': 'python' })
    call dein#add('davidhalter/jedi-vim', { 'on_ft': 'python' })
    call dein#add('python-rope/ropevim', { 'on_ft': 'python' })
    call dein#add('raimon49/requirements.txt.vim', {'on_ft': 'requirements'})
    call dein#add('Vimjas/vim-python-pep8-indent', { 'on_ft': 'python' })
    call dein#add('mindriot101/vim-yapf', { 'on_ft': 'python' })

    " JS
    call dein#add('elzr/vim-json', { 'on_ft': 'json' })
    call dein#add('pangloss/vim-javascript', { 'on_ft': 'javascript.jsx' })
    call dein#add('mxw/vim-jsx', { 'on_ft': 'javascript.jsx' })

    "Nim
    " call dein#add('baabelfish/nvim-nim', { 'on_ft': 'nim' })

    " Go
    call dein#add('zchee/deoplete-go', {'build': ['make', 'go get -u github.com/nsf/gocode'], 'on_ft': 'go'})
    call dein#add('fatih/vim-go', { 'hook_post_update': ':GoInstallBinaries', 'on_ft': 'go' })

    " " Rust
    " call dein#add('sebastianmarkow/deoplete-rust', {'on_ft': 'rust'})

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

" Generate tags
nnoremap <leader>T :Start! ctags -R .<CR>

" Thank you vi
nnoremap Y y$

" Exit insert mode by pressing <jk>
inoremap jk <Esc>

" Exit for command mode
cnoremap jk <Esc>

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

if exists(':tnoremap')
    " Allow movement seamlessly with terminals
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l

    " Exit for term mode
    tnoremap jk <C-\><C-n>

    " Automatic insert mode entering for terminal
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert

endif


" arrow keys move visible lines
inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
nnoremap <Down> gj
nnoremap <Up> gk

"" Tabs
nnoremap <silent> <S-t> :tab split<CR>

" <Enter> in normal mode will disable highlighting of current search.
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Visual line selection.
nnoremap <leader><leader> V

" Sudo hack
cmap w!! w !sudo tee % >/dev/null

" ------------------------------------------------------------------------------
" Plugins setup.
" ------------------------------------------------------------------------------

if g:dein#tap('deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#auto_completion_start_length = 0
endif


if g:dein#tap('fzf.vim')
    autocmd! FileType fzf tnoremap <buffer> jk <c-c>
    
    "search word under cursor
    nnoremap <leader>A :Ag <C-r><C-w><CR>   

    nnoremap <C-p> :Files<CR>
    nnoremap <leader>a :Ag<Space>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>c :Commands<CR>
    nnoremap <leader>h :Helptags<CR>
    nnoremap <leader>l :BLines<CR>
    nnoremap <leader>t :Tags<CR>
endif

if g:dein#tap('goyo.vim')
    nnoremap <leader>f :Goyo<CR>
endif


if g:dein#tap('vim-gitgutter')
    let g:gitgutter_realtime = 1
endif

if g:dein#tap('vim-autoformat')
    noremap <F3> :Autoformat<CR>
endif

if g:dein#tap('vim-fugitive')
    noremap <Leader>gc :Gcommit<CR>
    noremap <Leader>gsh :Gpush<CR>
    noremap <Leader>gll :Gpull<CR>
    noremap <Leader>gs :Gstatus<CR>
    noremap <Leader>gb :Gblame<CR>
    noremap <Leader>gd :Gvdiff<CR>
    noremap <Leader>gr :Gremove<CR>
endif


if g:dein#tap('neomake')
    autocmd! BufWritePost,BufEnter * Neomake " Run NeoMake on read and write operations
endif

if g:dein#tap('vim-dirvish')
    nnoremap <C-e> :Dirvish<CR>
    let g:dirvish_mode = ':sort ,^.*[\/],'

    augroup dirvish_events
        autocmd!

      " Map `t` to open in new tab.
        autocmd FileType dirvish
            \  nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
            \ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>

      " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
        autocmd FileType dirvish nnoremap <silent><buffer>
            \ gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>

    augroup END

endif

" ------------------------------------------------------------------------------
" Editor setup
" ------------------------------------------------------------------------------

" Color setup
set background=dark
let base16colorspace=256
colorscheme base16-ocean
syntax on

" Showcase comments in italics
highlight Comment cterm=italic gui=italic

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

" Statusline
set statusline=%f         " Path to the file
set statusline+=%m       " Modified flag
set statusline+=\ \      " Separator
set statusline+=%y        " Filetype of the file
set statusline+=\ \      " Separator
set statusline+=%l    " Current line
set statusline+=/   " Separator
set statusline+=%L   " Total lines

"omnicompletion settings
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

set nostartofline " Don’t reset cursor to start of line when moving around.
set showcmd " Show the (partial) command as it’s being typed

" Search settings
set incsearch
set hlsearch
set ignorecase
set smartcase
set infercase
set showmatch

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set cursorline
set wildmenu
set lazyredraw

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

"
" Disable vim background
" hi Normal ctermbg=none
