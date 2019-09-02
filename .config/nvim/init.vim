" vim:foldmethod=marker:foldlevel=0
" Basic settings.  {{{1
scriptencoding utf-8
set clipboard+=unnamedplus  " system clipboard
set hidden  " buffers
set wrap
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

set cmdheight=2

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

    " Style
    call dein#add('drewtempelmeyer/palenight.vim')

    " Files navigation.
    call dein#add('junegunn/fzf', { 'merged': 0, 'build': './install --bin' })
    call dein#add('junegunn/fzf.vim')

    " Code check.
    call dein#add('dense-analysis/ale')
    call dein#add('neoclide/coc.nvim', {'rev': 'release'})

    " Routine automation.
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-commentary')
    call dein#add('ervandew/supertab')

    " Async command execution
    call dein#add('tpope/vim-dispatch')

    " Tags
    call dein#add('ludovicchabant/vim-gutentags')

    " Git integration.
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    " Syntax highlightning for all languages.
    call dein#add('sheerun/vim-polyglot')

    " Python modules.
    call dein#add('numirias/semshi', { 'on_ft': 'python' })
    call dein#add('raimon49/requirements.txt.vim', { 'on_ft': 'requirements' })

    " Vim
    call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
    call dein#add('Kuniwak/vint', {'on_ft': 'vim'})

    " CSV
    call dein#add('chrisbra/csv.vim', {'on_ft': 'csv'})

    " JSON
    call dein#add('elzr/vim-json', { 'on_ft': 'json' })

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
nmap j gj
nmap k gk
nnoremap <C-e> :Explore<CR>


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
    tnoremap jk <C-\><C-n>
endif

nnoremap <silent> <S-t> :tab split<CR>
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <leader><leader> V
cmap w!! w !sudo tee % >/dev/null

" }}}
" Color setup {{{1
colorscheme palenight
function! UpdateStyle() abort
    set background=dark

    hi Normal ctermbg=none
    hi LineNr ctermbg=none cterm=none
    hi SignColumn ctermbg=none
    hi VertSplit ctermbg=none guibg=none
    hi Comment cterm=italic gui=italic

    hi User1 ctermfg=white
    hi User2 ctermfg=8
    hi User3 ctermfg=red

    hi StatusLineNC ctermbg=none cterm=none
    hi StatusLine ctermbg=none cterm=none
    hi TabLineFill ctermbg=none
    hi TabLineSel ctermbg=none
    hi Folded ctermbg=none

    set fillchars+=vert:│

    " hi StatusLine ctermfg=7
    " hi StatusLineNC ctermfg=240
    " set fillchars+=stlnc:_
    " set fillchars+=stl:_
endfunction

augroup EditorAppearance
    autocmd!
    autocmd ColorScheme * call UpdateStyle()
augroup END
" }}}
" Editor setup {{{1
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
set foldlevel=99

set noerrorbells  " No annoying errors
set novisualbell

set updatetime=250  

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" augroup BufferOptions
"     autocmd!
"     autocmd WinEnter * set cursorline
"     autocmd WinLeave * set nocursorline
" augroup END

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
        hi GitGutterAdd ctermbg=none ctermfg=darkgreen
        hi GitGutterChange ctermbg=none ctermfg=3
        hi GitGutterDelete ctermbg=none ctermfg=red
        hi GitGutterChangeDelete ctermbg=none ctermfg=red

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

if g:dein#is_sourced('semshi')
    function! SemshiStyleUpdate() abort
        hi semshiSelected ctermfg=none ctermbg=none
    endfunction
    autocmd EditorAppearance BufEnter * call SemshiStyleUpdate()
endif

if g:dein#is_sourced('coc.nvim')
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    let g:coc_global_extensions = [
        \ 'coc-css',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-python',
        \ 'coc-tsserver',
        \ 'coc-vetur',
        \ 'coc-yaml',
        \ 'coc-rls',
        \ 'coc-go',
    \ ]

    nmap <silent> <leader>g <Plug>(coc-type-definition)
    nmap <silent> <leader>d <Plug>(coc-definition)
    nmap <silent> <leader>i <Plug>(coc-implementation)
    nmap <silent> <leader>n <Plug>(coc-references)

    nnoremap <silent> K :call <SID>show_documentation()<CR>

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
    let g:ale_linters.python = ['pyflakes']
    let g:ale_python_flake8_options = '--ignore=E501'
    let g:ale_linters.rust = ['rls']
    let g:ale_linters.vim = ['vint']
    let g:ale_linters.yaml = ['yamllint']

    let g:ale_fixers.go = ['gofmt']
    let g:ale_fixers.html = ['prettier']
    let g:ale_fixers.javascript = ['standard']
    let g:ale_fixers.json = ['prettier']
    let g:ale_fixers.markdown = ['prettier']
    let g:ale_fixers.python = ['black']
    let g:ale_fixers.rust = ['rustfmt']
    let g:ale_fixers.sh = ['shfmt']
    let g:ale_fixers.yaml = ['prettier']


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
