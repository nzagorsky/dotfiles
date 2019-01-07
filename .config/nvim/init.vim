" vim:foldmethod=marker:foldlevel=0
" Basic settings.  {{{1
scriptencoding utf-8
set clipboard+=unnamedplus  " system clipboard
set hidden  " buffers
set nowrap
set noswapfile
set undofile
set undodir=~/.vim/undo
set backupdir=~/.vim/sessions
set directory=~/.vim/sessions

:silent call system('mkdir -p ' . &undodir)
:silent call system('mkdir -p ' . &directory)

set title
set titleold="Terminal"
set titlestring=%F

nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC <bar> bufdo e<CR>
nnoremap geft :Explore ~/.vim/ftplugin<CR>

set shortmess=aoOtIWcFs
" }}}
" Plugins {{{1
if (!isdirectory(expand('$HOME/.config/nvim/repos/github.com/Shougo/dein.vim')))
    call system(expand('mkdir -p $HOME/.config/nvim/repos/github.com'))
    call system(expand('git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim'))
endif

set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/

" Setup plugins
if dein#load_state(expand('~/.config/nvim'))
    call dein#begin(expand('~/.config/nvim'))
    call dein#add('Shougo/dein.vim')

    " Utility.
    if executable('tmux')
        call dein#add('christoomey/vim-tmux-navigator')
    endif

    " Colorscheme
    call dein#add('morhetz/gruvbox')
    call dein#add('junegunn/goyo.vim')

    " Files navigation.
    call dein#add('junegunn/fzf', { 'merged': 0, 'build': './install --bin' })
    call dein#add('junegunn/fzf.vim')
    call dein#add('tpope/vim-vinegar')

    " Code check.
    call dein#add('w0rp/ale')

    " Sessions
    call dein#add('tpope/vim-obsession')

    " Autocomplete
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('autozimu/LanguageClient-neovim', {'build': 'sh install.sh'})

    " Auto complete pairs.
    call dein#add('raimondi/delimitmate')

    " Routine automation.
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-commentary')
    call dein#add('ervandew/supertab')

    " Async command execution
    " call dein#add('skywind3000/asyncrun.vim')
    call dein#add('tpope/vim-dispatch')

    " Tags
    call dein#add('ludovicchabant/vim-gutentags')

    " Git integration.
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    " Syntax highlightning for all languages.
    call dein#add('sheerun/vim-polyglot')

    " Python modules.
    call dein#add('zchee/deoplete-jedi', { 'on_ft': 'python' })
    call dein#add('raimon49/requirements.txt.vim', { 'on_ft': 'requirements' })

    " JS
    call dein#add('elzr/vim-json', { 'on_ft': 'json' })
    call dein#add('pangloss/vim-javascript', { 'on_ft': 'javascript.jsx' })
    call dein#add('mxw/vim-jsx', { 'on_ft': 'javascript.jsx' })

    " Nim
    call dein#add('zah/nim.vim', { 'on_ft': 'nim' })

    " Go
    call dein#add('fatih/vim-go', { 'hook_post_update': ':GoInstallBinaries', 'on_ft': 'go' })

    " Zsh
    call dein#add('zchee/deoplete-zsh', { 'on_ft': 'zsh' })

    " Vim
    call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
    call dein#add('Kuniwak/vint', {'on_ft': 'vim'})

    if dein#check_install()
      call dein#install()
    endif

    call dein#end()
endif

" }}}
" Key bindings {{{1
let mapleader = "\<Space>"
nnoremap Y y$
inoremap jk <Esc>
cnoremap jk <Esc>
nnoremap <Leader>w :w<CR>
nnoremap <leader>q :close<CR>
nnoremap <leader>k :bd<CR>
nmap <Leader><Leader> V

" Remove trailing whitespaces
nnoremap<leader>S :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

if exists(':tnoremap')
    augroup TerminalConfiguration
        autocmd BufWinEnter,WinEnter term://* startinsert
        autocmd BufLeave term://* stopinsert
    augroup END

    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    tnoremap gt <C-\><C-n>gt 
    tnoremap gT <C-\><C-n>gT 
    tnoremap jk <C-\><C-n>
endif

nnoremap <silent> <S-t> :tab split<CR>
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <leader><leader> V
cmap w!! w !sudo tee % >/dev/null

" }}}
" Color setup {{{1
colorscheme gruvbox
let g:gruvbox_contrast_dark='dark'
set background=dark

function! UpdatedHighlights() abort
    hi Normal ctermbg=none
    hi LineNr ctermbg=none cterm=none
    hi SignColumn ctermbg=none
    hi VertSplit ctermbg=none guibg=none
    hi Comment cterm=italic gui=italic

    hi User1 ctermfg=white
    hi User2 ctermfg=8
    hi User3 ctermfg=red

    " hi StatusLine ctermfg=7
    " hi StatusLineNC ctermfg=240

    hi StatusLineNC ctermbg=none cterm=none
    hi StatusLine ctermbg=none cterm=none
    hi TabLineFill ctermbg=none
    hi TabLineSel ctermbg=none
    hi Folded ctermbg=none

    set fillchars+=vert:│
    " set fillchars+=stlnc:_
    " set fillchars+=stl:_
endfunction

augroup EditorAppearance
    autocmd!
    autocmd ColorScheme * call UpdatedHighlights()
augroup END
" }}}
" Editor setup {{{1
syntax on
filetype indent on
filetype plugin on
filetype plugin indent on " Enable filetype plugins and indention

set completeopt-=preview
set lazyredraw
set scrolloff=3
set textwidth=0  " Do not break the line while typing
set showcmd " Show the (partial) command as it’s being typed
set nostartofline " Don’t reset cursor to start of line when moving around.

set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Search settings
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
set foldmethod=marker
set foldlevel=0

set noerrorbells  " No annoying errors
set novisualbell

set updatetime=250  

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
" }}}
" Statusline {{{1
" To format status line wrap with `%#* and %*` where # is User number.
set laststatus=2

set statusline=

set statusline+=\ %*  " Separator
set statusline+=\ %f\ %*  " Path
" set statusline+=\ %t\ %*  " Path
set statusline+=\ %m
set statusline+=%=

set statusline+=%3*
set statusline+=\ %{LinterStatus()}
set statusline+=%*

" Filetype
set statusline+=\ %Y\  

" Git branch data
" set statusline+=%1*
" set statusline+=⎇\ %{GitBranch()}
" set statusline+=%*

" Line numbers
" set statusline+=%1*
set statusline+=\ %l\/%L
" set statusline+=%*


" }}}
" Plugins setup.  {{{1
if g:dein#is_sourced('fzf.vim')
    function! UpdateTags() abort
        :Start! ctags .<CR>
    endfunction

    function! s:FzfHighlights()
      highlight fzf1 ctermbg=none
      highlight fzf2 ctermbg=none
      highlight fzf3 ctermbg=none
    endfunction

    augroup FzfSettings
        autocmd! FileType fzf tnoremap <buffer> jk <c-c>
        autocmd! User FzfStatusLine call <SID>FzfHighlights()
    augroup END

    
    "search word under cursor
    nnoremap <leader>A :Rg <C-r><C-w><CR>   

    nnoremap <leader>f :Files<CR>
    nnoremap <leader>a :Rg<Space>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>c :Commands<CR>
    nnoremap <leader>h :Helptags<CR>
    nnoremap <leader>l :Lines<CR>
    nnoremap <leader>t :Tags<CR>
    nnoremap <leader>T :call UpdateTags()<CR>

    " Use ripgrep
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
endif

if g:dein#is_sourced('vim-polyglot')
    let g:polyglot_disabled = ['yaml', 'python']
endif

if g:dein#is_sourced('vim-gitgutter')
    let g:gitgutter_realtime = 1
    function! GitGutterStyleUpdate() abort
        hi GitGutterAdd ctermbg=none ctermfg=green
        hi GitGutterChange ctermbg=none ctermfg=yellow
        hi GitGutterDelete ctermbg=none ctermfg=red
        hi GitGutterChangeDelete ctermbg=none
    endfunction
    autocmd EditorAppearance BufEnter * call GitGutterStyleUpdate()

endif

if g:dein#is_sourced('vim-fugitive')
    function! GitBranch() abort
        let l:stripped_git_status = matchstr(fugitive#statusline(), '(.*)')[1:-2]
        return l:stripped_git_status
    endfunction

    noremap <Leader>gs :Gstatus<CR>
    noremap <Leader>gc :Gcommit<CR>
    noremap <Leader>gpush :Gpush<CR>
    noremap <Leader>gpull :Gpull<CR>
    noremap <Leader>gb :Gblame<CR>
    noremap <Leader>gd :Gvdiff<CR>
    noremap <Leader>gr :Gremove<CR>
endif

if g:dein#is_sourced('deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
    function! DeopleteStyleUpdate() abort
        " 223 white, 8 blue, 0 black
        hi Pmenu ctermbg=8 ctermfg=223
        hi PmenuSel ctermbg=0 ctermfg=8
        hi PmenuSbar ctermbg=0
    endfunction
    autocmd EditorAppearance BufEnter * call DeopleteStyleUpdate()

    call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
    call deoplete#custom#option({
    \ 'auto_complete_delay': 0,
    \ 'smart_case': v:true,
    \ 'max_list': 20,
    \ 'min_pattern_length': 1,
    \ })
    call deoplete#custom#option('sources', {
    \ '_': ['buffer', 'tag'],
    \ 'python': ['jedi'],
    \ 'vim': ['vim'],
    \ 'zsh': ['zsh'],
    \})

    " augroup AutoComplete
    "     autocmd BufWinEnter '__doc__' setlocal bufhidden=delete
    "     autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    " augroup END

   " call deoplete#custom#option('profile', v:true)
   " call deoplete#enable_logging('DEBUG', 'deoplete.log')
endif

if g:dein#is_sourced('LanguageClient-neovim')
    let g:LanguageClient_serverCommands = {
        \ 'python': ['pyls'],
        \ }
    let g:LanguageClient_diagnosticsEnable = 0

    nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
endif

if g:dein#is_sourced('ale')
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

    function! AleStyleUpdate() abort
        hi ALEError ctermbg=none
        hi ALEErrorLine ctermbg=none
        hi ALEErrorSign ctermbg=none ctermfg=red " Red

        hi ALEWarning ctermbg=none
        hi ALEWarningLine ctermbg=none
        hi ALEWarningSign ctermbg=none ctermfg=3 " Yellow
    endfunction

    autocmd EditorAppearance BufEnter * call AleStyleUpdate()

    noremap <F3> :ALEFix<CR>

    let g:ale_sign_warning = '~'
    let g:ale_sign_error = 'x'

    let g:ale_linters = {}
    let g:ale_fixers = {}

    let g:ale_linters.javascript = ['standard']
    let g:ale_fixers.javascript = ['standard']

    let g:ale_linters.python = ['flake8']
    let g:ale_python_flake8_options = '--ignore=E501'
    let g:ale_fixers.python = ['black']

    let g:ale_fixers.yaml = ['prettier']
    let g:ale_linters.yaml = ['yamllint']

    let g:ale_linters.vim = ['vint']
    let g:ale_fixers.go = ['gofmt']
    let g:ale_fixers.html = ['prettier']
    let g:ale_fixers.json = ['prettier']
    let g:ale_fixers.markdown = ['prettier']

endif

if g:dein#is_sourced('vim-vinegar')
    nnoremap <C-e> :Explore<CR>
endif

if g:dein#is_sourced('supertab')
    let g:SuperTabDefaultCompletionType='<c-n>'
endif
" }}}
" Utility functions {{{1
" Creating parent folders if they doesn't exist on buffer save.
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup AutomaticDirectoryCreation
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
