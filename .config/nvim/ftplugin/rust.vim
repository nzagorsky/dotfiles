let g:deoplete#sources#rust#racer_binary=$HOME.'/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/usr/lib/rustlib/src/rust/src/'
let g:deoplete#sources#rust#show_duplicates=0
let g:deoplete#sources#rust#disable_keymap=1
let g:deoplete#sources#rust#documentation_max_height=30

nmap <buffer> <Leader>d <plug>DeopleteRustGoToDefinitionDefault
nmap <buffer> <Leader>k <plug>DeopleteRustShowDocumentation
