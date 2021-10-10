
vim.cmd(
    [[

    " Dadbod
    let g:db_ui_winwidth = 30
    let g:dbs = {
    \  'localdocker': 'postgres://postgres:1337@localhost:5435/postgres',
    \  'local': 'postgres://toltenos:@localhost:5432/postgres'
    \ }

    " Slime
    let g:slime_target = "neovim"

    " Semshi
    function! SemshiStyleUpdate() abort
        hi semshiSelected ctermfg=none ctermbg=none
    endfunction
    autocmd EditorAppearance BufEnter * call SemshiStyleUpdate()


    ]]
    )
