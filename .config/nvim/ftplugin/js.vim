let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_javascript_jshint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
set omnifunc=javascriptcomplete#CompleteJS
set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4
