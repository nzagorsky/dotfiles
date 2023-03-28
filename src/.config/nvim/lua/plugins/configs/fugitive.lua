vim.cmd(
    [[
    function! GitBranch() abort
        let l:stripped_git_status = matchstr(fugitive#statusline(), '(.*)')[1:-2]
        return l:stripped_git_status
    endfunction

    noremap <Leader>gs :Git<CR>
    noremap <Leader>gc :Git commit<CR>
    noremap <Leader>gpush :Git push<CR>
    noremap <Leader>gpull :Git pull<CR>
    noremap <Leader>gb :Git blame<CR>
    noremap <Leader>gd :Gvdiff<CR>
    noremap <Leader>gr :GRemove<CR>
    ]]
)
