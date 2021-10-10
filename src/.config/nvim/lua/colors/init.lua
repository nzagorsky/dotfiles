
vim.cmd(
    [[
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
    colorscheme palenight
    ]]
)

