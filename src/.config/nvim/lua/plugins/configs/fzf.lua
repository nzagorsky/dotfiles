vim.cmd [[
function! FZFBuildQuickFixList(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('FZFBuildQuickFixList'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! UpdateTags() abort
    :Start! ctags .<CR>
endfunction

function! FzfHighlights()
  highlight fzf1 ctermbg=none
  highlight fzf2 ctermbg=none
  highlight fzf3 ctermbg=none
endfunction

augroup FzfSettings
    autocmd! FileType fzf tnoremap <buffer> jk <c-c>
    autocmd! User FzfStatusLine call FzfHighlights()
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
  \   'rg --hidden --glob "!.git/" --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
]]
