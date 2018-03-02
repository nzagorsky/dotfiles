nnoremap <buffer> <Leader>r :GoRun<CR>
nnoremap <buffer> <Leader>k :GoDoc<CR>
nnoremap <buffer> <Leader>d :GoDef<CR>
nnoremap <buffer> <Leader>b :GoBuild<CR>
nnoremap <buffer> <Leader>t :GoTest<CR>

let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#pointer = 1
