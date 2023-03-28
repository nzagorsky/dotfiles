vim.cmd([[
    function! CocShowDocs()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    function! CocCheckBackSpace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_global_extensions = [
        \ 'coc-css',
        \ 'coc-docker',
        \ 'coc-sh',
        \ 'coc-git',
        \ 'coc-go',
        \ 'coc-html',
        \ 'coc-emmet',
        \ 'coc-json',
        \ 'coc-sql',
        \ 'coc-lua',
        \ 'coc-db',
        \ 'coc-prettier',
        \ 'coc-pyright',
        \ 'coc-rls',
        \ 'coc-tsserver',
        \ 'coc-vetur',
        \ 'coc-yaml',
        \ '@yaegassy/coc-ansible',
        \ 'coc-vimlsp',
    \ ]

    let g:coc_filetype_map = {
      \ 'yaml.ansible': 'ansible',
      \ }


    function! CocFormatImports()
        CocCommand python.sortImports
    endfunction

    function! CocFormatCode()
        call CocAction('format')
    endfunction

    nmap <silent> <leader>g <Plug>(coc-type-definition)
    nmap <silent> <leader>d <Plug>(coc-definition)
    nmap <silent> <leader>i <Plug>(coc-implementation)
    nmap <silent> <leader>n <Plug>(coc-references)
    nmap <silent> <leader>rn <Plug>(coc-rename)
    nmap <silent> gd <Plug>(coc-definition)
    nnoremap <silent> K :call CocShowDocs()<CR>
    nnoremap <silent> <F3>  :call CocFormatCode()<CR>
    nnoremap <silent> <F4>  :call CocFormatImports()<CR>

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
          \ CocCheckBackSpace() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


    " ctrl-space autocommpletion
    inoremap <silent><expr> <c-space> coc#refresh()

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
]])
