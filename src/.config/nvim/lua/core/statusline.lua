vim.cmd([[

    " To format status line wrap with `%#* and %*` where # is User number.
    set laststatus=2

    set statusline=

    set statusline+=\ %*  " Separator
    set statusline+=\ %f\ %*  " Path
    " set statusline+=\ %t\ %*  " Path
    set statusline+=\ %m
    set statusline+=%=

    " Filetype
    set statusline+=%Y

    " Git branch data
    " set statusline+=%1*
    " set statusline+=⎇\ %{GitBranch()}
    " set statusline+=%*

    " Line numbers
    " set statusline+=%1*
    set statusline+=\ %l\/%L
    " set statusline+=%*

    ]])
