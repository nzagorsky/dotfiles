let g:nvim_nim_enable_async = 0
let g:nvim_nim_highlighter_enable = 1
let g:nvim_nim_highlight_builtin = 1
let g:nvim_nim_enable_default_binds = 0

nnoremap <buffer> <Leader>d    :NimDefinition<cr>
nnoremap <buffer> <Leader>i    :NimInfo<cr>
nnoremap <buffer> <Leader>r    :NimRenameSymbol<cr>
nnoremap <buffer> <Leader>ra   :NimRenameSymbolProject<cr>

