return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    opts = {
        ensure_installed = { "comment" },
        auto_install = true,
        indent = {
            enable = true,
        },
        highlight = {
            enable = true,
            use_languagetree = true,
        },
    },
    -- branch = "main",
    build = ":TSUpdate",
    dependencies = {
        {
            "windwp/nvim-ts-autotag",
            opts = {
                autotag = {
                    enable = true,
                },
            },
        },
    },
}
