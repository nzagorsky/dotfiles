return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup {
            open_mapping = [[<a-j>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
            direction = "float",
        }

        -- https://github.com/akinsho/toggleterm.nvim/issues/610
        vim.api.nvim_create_augroup("disable_folding_toggleterm", { clear = true })

        vim.api.nvim_create_autocmd("FileType", {
            group = "disable_folding_toggleterm",
            pattern = "toggleterm",
            callback = function(ev)
                local bufnr = ev.buf
                vim.api.nvim_buf_set_option(bufnr, "foldmethod", "manual")
                vim.api.nvim_buf_set_option(bufnr, "foldtext", "foldtext()")
            end,
        })
    end,
}
