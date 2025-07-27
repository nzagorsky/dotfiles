return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            library = {
                "${3rd}/love2d/library",
            },
        },
    },
}
