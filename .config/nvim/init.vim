" --------------------
" Basic settings.
" --------------------
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard+=unnamedplus

" hide buffers, not close them
set hidden

" do not wrap lines
set nowrap

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undo

" Move Backup Files to ~/.vim/sessions
set backupdir=~/.vim/sessions
set directory=~/.vim/sessions

set noswapfile
:silent call system('mkdir -p ' . &undodir)
:silent call system('mkdir -p ' . &directory)

" enable automatic title setting for terminals
set title
set titleold="Terminal"
set titlestring=%F

" Quickly edit and source vimrc, updating all buffers.
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC <bar> bufdo e<CR>
nnoremap geft :Explore ~/.vim/ftplugin<CR>

" Don't show the intro message when starting Vim
set shortmess=aoOtIWcFs

" --------------------
" Plugins
" --------------------
" Setup dein
if (!isdirectory(expand('$HOME/.config/nvim/repos/github.com/Shougo/dein.vim')))
    call system(expand('mkdir -p $HOME/.config/nvim/repos/github.com'))
    call system(expand('git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim'))
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

    " Colorscheme
    call dein#add('morhetz/gruvbox')

    " Files navigation.
    call dein#add('junegunn/fzf', { 'merged': 0, 'build': './install --bin' })
    call dein#add('junegunn/fzf.vim')
    call dein#add('tpope/vim-vinegar')

    " Code check.
    call dein#add('w0rp/ale')

    " Auto complete pairs.
    call dein#add('raimondi/delimitmate')

    " Routine automation.
    call dein#add('ervandew/supertab')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-commentary')

    " Async command execution
    call dein#add('skywind3000/asyncrun.vim')
    call dein#add('tpope/vim-dispatch')

    " Tags
    call dein#add('ludovicchabant/vim-gutentags')

    " Git integration.
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    " Syntax highlightning for all languages.
    call dein#add('sheerun/vim-polyglot')

    " Python modules.
    call dein#add('nvie/vim-flake8', { 'on_ft': 'python' })
    call dein#add('raimon49/requirements.txt.vim', {'on_ft': 'requirements'})

    " JS
    call dein#add('elzr/vim-json', { 'on_ft': 'json' })
    call dein#add('pangloss/vim-javascript', { 'on_ft': 'javascript.jsx' })
    call dein#add('mxw/vim-jsx', { 'on_ft': 'javascript.jsx' })

    " Nim
    call dein#add('zah/nim.vim', { 'on_ft': 'nim' })

    " Go
    call dein#add('fatih/vim-go', { 'hook_post_update': ':GoInstallBinaries', 'on_ft': 'go' })
    " call dein#add('zchee/deoplete-go', {'build': 'make'})

    " Vim
    call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
    call dein#add('Kuniwak/vint', {'on_ft': 'vim'})

    " " LSP
    " call dein#add('autozimu/LanguageClient-neovim', {
    " \ 'rev': 'next',
    " \ 'build': 'bash install.sh',
    " \ })

    " Snippets
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

    if dein#check_install()
      call dein#install()
      let pluginsExist=1
    endif

    call dein#end()
endif


" --------------------
"  Functions
" --------------------
function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors

   let l:return_value=''
   if l:all_errors > 0
       let l:return_value=l:all_errors

   endif

   return l:return_value

endfunction

function! GitBranch() abort
    let l:stripped_git_status = matchstr(fugitive#statusline(), '(.*)')[1:-2]
    return l:stripped_git_status
endfunction

function! UpdateTags() abort
    :Start! ctags .<CR>
endfunction


" --------------------
" Key bindings
" --------------------
let mapleader = "\<Space>"

" Generate tags
nnoremap <leader>T :call UpdateTags()<CR>

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

    " Switch tab properly
    tnoremap gt <C-\><C-n>gt 
    tnoremap gT <C-\><C-n>gT 

    " Exit for term mode
    tnoremap jk <C-\><C-n>

    " Automatic insert mode entering for terminal
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert

endif

"" Tabs
nnoremap <silent> <S-t> :tab split<CR>

" <Enter> in normal mode will disable highlighting of current search.
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Visual line selection.
nnoremap <leader><leader> V

" Sudo hack
cmap w!! w !sudo tee % >/dev/null

" --------------------
" Editor setup
" --------------------
" Color setup
colorscheme gruvbox
set background=dark
syntax on

" Disable vim background
hi Normal ctermbg=none

" Disable coloring of sign column on the left.
hi SignColumn ctermbg=none

" Disable linenr on the left
hi LineNr ctermbg=none cterm=none

" Change split separator appearance to be less distracting
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE


" Showcase comments in italics
highlight Comment cterm=italic gui=italic

filetype indent on
filetype plugin on
filetype plugin indent on " Enable filetype plugins and indention

set scrolloff=3 " keep some more lines for scope

set smarttab
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab
set softtabstop=4

" omnicompletion settings
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Prevent line breaking
set textwidth=0

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

set wildmenu
set lazyredraw

set foldenable
set foldmethod=indent
set foldlevel=99
set noerrorbells  " No annoying errors
set novisualbell
set updatetime=250  

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" --------------------
" Statusline
" --------------------

hi User1 ctermfg=white
hi User2 ctermfg=8  " Dark gray
hi User3 ctermfg=red
hi StatusLine ctermfg=8   " `8` == comment color

" To format status line wrap with `%#* and %*` where # is User number.
set laststatus=2
set statusline=

set statusline+=\ %*  " Separator
" set statusline+=\ %10.50f\ %*  " Path
set statusline+=\ %t\ %*  " Path
set statusline+=\ %m
set statusline+=%=

set statusline+=%3*
set statusline+=\ %{LinterStatus()}\ 
set statusline+=%*

" Filetype
" set statusline+=\ %3.3Y\  

" Git branch data
" set statusline+=%1*
" set statusline+=⎇\ %{GitBranch()}
" set statusline+=%*

" Line numbers
" set statusline+=%1*
set statusline+=\ %l\/%L
" set statusline+=%*

hi StatusLineNC ctermbg=none cterm=none
hi StatusLine ctermbg=none cterm=none

" --------------------
" Plugins setup.
" --------------------

if g:dein#is_sourced('fzf.vim')
    autocmd! FileType fzf tnoremap <buffer> jk <c-c>
    
    "search word under cursor
    nnoremap <leader>A :Ag <C-r><C-w><CR>   

    nnoremap <C-p> :Files<CR>
    nnoremap <leader>a :Ag<Space>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>c :Commands<CR>
    nnoremap <leader>h :Helptags<CR>
    nnoremap <leader>l :Lines<CR>
    nnoremap <leader>t :Tags<CR>
endif

if g:dein#is_sourced('goyo.vim')
    nnoremap <leader>f :Goyo<CR>
endif

if g:dein#is_sourced('vim-polyglot')
    let g:polyglot_disabled = ['yaml', 'python']
endif

if g:dein#is_sourced('vim-gitgutter')
    let g:gitgutter_realtime = 1
    " Disable BG for gitgutter signs
    hi GitGutterAdd ctermbg=none ctermfg=green
    hi GitGutterChange ctermbg=none ctermfg=yellow
    hi GitGutterDelete ctermbg=none ctermfg=red
endif

if g:dein#is_sourced('vim-fugitive')
    noremap <Leader>gc :Gcommit<CR>
    noremap <Leader>gsh :Gpush<CR>
    noremap <Leader>gll :Gpull<CR>
    noremap <Leader>gs :Gstatus<CR>
    noremap <Leader>gb :Gblame<CR>
    noremap <Leader>gd :Gvdiff<CR>
    noremap <Leader>gr :Gremove<CR>
endif

" if g:dein#is_sourced('deoplete.nvim')
"     let g:deoplete#enable_at_startup = 1
" endif

if g:dein#is_sourced('ale')
    noremap <F3> :ALEFix<CR>
    nnoremap <silent> <leader>d :ALEGoToDefinition<CR>
    nnoremap <silent> <leader>n :ALEFindReferences<CR>
    nnoremap <silent> K :ALEHover<CR>

    let g:ale_completion_enabled = 1
    let g:ale_completion_max_suggestions = 20
    let g:ale_completion_delay = 0

    let g:ale_sign_error = 'x'
    let g:ale_sign_warning = '~'

    hi ALEError ctermbg=none
    hi ALEErrorLine ctermbg=none
    hi ALEErrorSign ctermbg=none ctermfg=red " Red

    hi ALEWarning ctermbg=none
    hi ALEWarningLine ctermbg=none
    hi ALEWarningSign ctermbg=none ctermfg=3 " Yellow

    let g:ale_linters = {}
    let g:ale_fixers = {}

    " JS
    let g:ale_linters.javascript = ['standard']
    let g:ale_fixers.javascript = ['standard']

    " Python
    let g:ale_linters.python = ['pyls']
    let g:ale_fixers.python = ['black']

    " Yaml
    let g:ale_fixers.yaml = ['prettier']
    let g:ale_linters.yaml = ['yamllint']

    " Rest
    let g:ale_linters.vim = ['vint']
    let g:ale_fixers.go = ['gofmt']
    let g:ale_fixers.html = ['prettier']
    let g:ale_fixers.json = ['prettier']
    let g:ale_fixers.markdown = ['prettier']

endif

if g:dein#is_sourced('neosnippet.vim')
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
endif

if g:dein#is_sourced('vim-vinegar')
    nnoremap <C-e> :Explore<CR>
endif

" Creating parent folders if they doesn't exist on buffer save.
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" Enable syntax highlighting when buffers were loaded through :bufdo, which
" disables the Syntax autocmd event to speed up processing.
augroup EnableSyntaxHighlighting
    autocmd! BufWinEnter * nested if exists('syntax_on') && ! exists('b:current_syntax') && ! empty(&l:filetype) | syntax enable | endif
    autocmd! BufRead * if exists('syntax_on') && exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') != -1 | unlet! b:current_syntax | endif
augroup END
