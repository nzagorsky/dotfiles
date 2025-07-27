return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    -- branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "comment" },
            auto_install = true,
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
                use_languagetree = true,
            },
        }
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
            "windwp/nvim-ts-autotag",
            config = function()
                require("nvim-treesitter.configs").setup {
                    autotag = {
                        enable = true,
                    },
                }
            end,
        },
    },
}
