" vim:foldmethod=marker:foldlevel=0
" Basic settings {{{1
scriptencoding utf-8
set clipboard+=unnamedplus  " system clipboard
set signcolumn=yes   " no more fucking text shifting
set hidden  " buffers
set wrap
set noswapfile
set undofile
set undodir=~/.config/nvim/undo
set backupdir=~/.config/nvim/sessions
set directory=~/.config/nvim/sessions

set title
set titleold="Terminal"
set titlestring=%F

set cmdheight=2

nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC <bar> bufdo e<CR>

set shortmess=aoOtIWcFs
" }}}
" Plugins {{{1
if (!isdirectory(expand('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')))
    call system(expand('mkdir -p $HOME/.cache/dein/repos/github.com'))
    call system(expand('git clone https://github.com/Shougo/dein.vim $HOME/.cache/dein/repos/github.com/Shougo/dein.vim'))
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Setup plugins
" let g:dein#auto_recache = 1
if dein#load_state(expand('~/.cache/dein'))
    call dein#begin(expand('~/.cache/dein'))

    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

    " Python modules.
    call dein#add('numirias/semshi', {'on_ft': 'python'})
    call dein#add('raimon49/requirements.txt.vim', { 'on_ft': 'requirements' })

    " Utility.
    if exists('$TMUX')
        call dein#add('christoomey/vim-tmux-navigator')
    endif

    " Style
    call dein#add('drewtempelmeyer/palenight.vim')
    call dein#add('arcticicestudio/nord-vim')
    call dein#add('w0ng/vim-hybrid')
    call dein#add('rakr/vim-one')

    "Files navigation.
    call dein#add('junegunn/fzf', { 'merged': 0, 'build': './install --bin' })
    call dein#add('junegunn/fzf.vim')

    " Code check.
    call dein#add('neoclide/coc.nvim', {'rev': 'release'})

    " Routine automation.
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-commentary')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('junegunn/goyo.vim')

    " Async command execution
    call dein#add('tpope/vim-dispatch')

    " Tags
    call dein#add('ludovicchabant/vim-gutentags')

    " Git integration.
    call dein#add('tpope/vim-fugitive')

    " Syntax highlightning for all languages.
    call dein#add('sheerun/vim-polyglot')

    " Vim
    call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})

    " JSON
    call dein#add('elzr/vim-json', { 'on_ft': 'json' })

    " REPL
    call dein#add('jpalardy/vim-slime')

    " DB
    call dein#add('tpope/vim-dadbod')
    call dein#add('kristijanhusak/vim-dadbod-ui')

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
nnoremap <leader>kb :bd<CR>
nmap <Leader><Leader> V
nmap j gj
nmap k gk
nnoremap <C-e> :Explore<CR>
nnoremap <A-x> :Commands<CR>


" Remove trailing whitespaces
nnoremap<leader>S :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

if exists(':tnoremap')
    " Enter terminal insert mode on enter.
    " augroup TerminalConfiguration
    "     autocmd BufWinEnter,WinEnter term://* startinsert
    "     autocmd BufLeave term://* stopinsert
    " augroup END

    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    tnoremap jk <C-\><C-n>
endif

nnoremap <silent> <S-t> :tab split<CR>
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <leader><leader> V
cmap w!! w !sudo tee % >/dev/null

" Alt-based tab navigation {{{
if !exists('$TMUX')
    nnoremap <A-1> <Esc>1gt
    nnoremap <A-2> <Esc>2gt
    nnoremap <A-3> <Esc>3gt
    nnoremap <A-4> <Esc>4gt
    nnoremap <A-5> <Esc>5gt
    nnoremap <A-6> <Esc>6gt
    nnoremap <A-7> <Esc>7gt
    nnoremap <A-8> <Esc>8gt
    nnoremap <A-9> <Esc>9gt
    nnoremap <A-0> <Esc>10gt

    inoremap <A-1> <Esc>1gt
    inoremap <A-2> <Esc>2gt
    inoremap <A-3> <Esc>3gt
    inoremap <A-4> <Esc>4gt
    inoremap <A-5> <Esc>5gt
    inoremap <A-6> <Esc>6gt
    inoremap <A-7> <Esc>7gt
    inoremap <A-8> <Esc>8gt
    inoremap <A-9> <Esc>9gt
    inoremap <A-0> <Esc>10gt

    tnoremap <A-1> <C-\><C-n>1gt
    tnoremap <A-2> <C-\><C-n>2gt
    tnoremap <A-3> <C-\><C-n>3gt
    tnoremap <A-4> <C-\><C-n>4gt
    tnoremap <A-5> <C-\><C-n>5gt
    tnoremap <A-6> <C-\><C-n>6gt
    tnoremap <A-7> <C-\><C-n>7gt
    tnoremap <A-8> <C-\><C-n>8gt
    tnoremap <A-9> <C-\><C-n>9gt
    tnoremap <A-0> <C-\><C-n>10gt

    nnoremap <A-h> <Esc>:tabprevious<CR>
    inoremap <A-h> <Esc>:tabprevious<CR>
    tnoremap <A-h> <C-\><C-n>:tabprevious<CR>

    nnoremap <A-l> <Esc>:tabnext<CR>
    inoremap <A-l> <Esc>:tabnext<CR>
    tnoremap <A-l> <C-\><C-n>:tabnext<CR>
endif
" }}}

" }}}
" Color setup {{{1
colorscheme palenight
function! UpdateStyle() abort
    set background=dark

    hi Normal ctermbg=none guibg=none
    hi LineNr ctermbg=none cterm=none
    hi SignColumn ctermbg=none guibg=none
    hi VertSplit ctermbg=none guibg=none
    hi Comment cterm=italic gui=italic

    hi User1 ctermfg=white
    hi User2 ctermfg=8
    hi User3 ctermfg=red

    hi StatusLineNC ctermbg=none ctermfg=8 cterm=none guibg=none gui=none
    hi StatusLine ctermbg=none cterm=none guibg=none gui=none
    hi TabLine ctermbg=none
    hi TabLineFill ctermbg=none guibg=none
    hi TabLineSel ctermbg=none guibg=none
    hi Folded ctermbg=none guibg=none

    set fillchars+=vert:│

    hi DiffAdd ctermbg=none ctermfg=darkgreen
    hi DiffChange ctermbg=none ctermfg=3
    hi DiffDelete ctermbg=none ctermfg=red

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

" augroup BgHighlight
"     autocmd!
"     autocmd WinEnter * set relativenumber
"     autocmd WinLeave * set norelativenumber
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
set statusline+=\ %{StatusDiagnostic()}  " coc diagnostic message
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
" Plugins setup {{{1
"
call dein#config('sheerun/vim-polyglot', {
            \ 'hook_source': "let g:polyglot_disabled = ['python']"
            \ })

if g:dein#is_sourced('fzf.vim')
    function! s:build_quickfix_list(lines)
      call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
      copen
      cc
    endfunction

    let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

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

    " TODO not woring currently, will wok in tmux 3.2
    " if exists('$TMUX')
    "   let g:fzf_layout = { 'tmux': '-p90%,60%' }
    " else
    " endif
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

    " autocmd! FileType fzf
    " autocmd  FileType fzf set laststatus=0 noshowmode noruler
    "   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

    "search word under cursor
    nnoremap <leader>A :Rg <C-r><C-w><CR>   

    nnoremap <leader>f :Files<CR>
    nnoremap <leader>a :Rg<Space>
    nnoremap <leader>b :Buffers<CR>
    " nnoremap <leader>c :Commands<CR>
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

if g:dein#is_sourced('vim-slime')
    let g:slime_target = "neovim"
endif

if g:dein#is_sourced('vim-dadbod-ui')

    let g:db_ui_winwidth = 30
    let g:dbs = {
    \  'local': 'postgres://postgres:1337@localhost:5435/postgres'
    \ }
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
        \ 'coc-docker',
        \ 'coc-sh',
        \ 'coc-git',
        \ 'coc-go',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-sql',
        \ 'coc-db',
        \ 'coc-prettier',
        \ 'coc-pyright',
        \ 'coc-rls',
        \ 'coc-tsserver',
        \ 'coc-vetur',
        \ 'coc-yaml',
        \ 'coc-vimlsp',
    \ ]

    function! s:format_code()
        if (&ft=='python')
            call CocAction('format') | CocCommand python.sortImports
        else
            call CocActionAsync('format')
        endif
    endfunction

    nmap <silent> <leader>g <Plug>(coc-type-definition)
    nmap <silent> <leader>d <Plug>(coc-definition)
    nmap <silent> <leader>i <Plug>(coc-implementation)
    nmap <silent> <leader>n <Plug>(coc-references)
    nmap <silent> <leader>rn <Plug>(coc-rename)
    nmap <silent> gd <Plug>(coc-definition)
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    nnoremap <silent> <F3>  :call <SID>format_code()<CR>

    " coc-git
    nmap [g <Plug>(coc-git-prevchunk)
    nmap ]g <Plug>(coc-git-nextchunk)
    nmap gs <Plug>(coc-git-chunkinfo)
    nmap gu :CocCommand git.chunkUndo<cr>

    " diagnostics navigation
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Proper tab autocommpletion
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " ctrl-space autocommpletion
    inoremap <silent><expr> <c-space> coc#refresh()

    " Statusline method to show errors and warnings.
	function! StatusDiagnostic() abort
	  let info = get(b:, 'coc_diagnostic_info', {})
	  if empty(info) | return '' | endif
	  let msgs = []

	  if get(info, 'error', 0)
	    call add(msgs, 'E' . info['error'])
	  endif

	  if get(info, 'warning', 0)
	    call add(msgs, 'W' . info['warning'])
	  endif
	  return join(msgs, ' ')
	endfunction

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

" }}}
