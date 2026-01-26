return {
    {
        "saghen/blink.cmp",
        dependencies = {
            { "rafamadriz/friendly-snippets" },
            { "saghen/blink.compat" },
        },
        event = { "InsertEnter", "CmdlineEnter" },
        version = "1.*",

        opts = {
            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
                providers = {
                    lsp = {
                        score_offset = 10,
                    },
                    buffer = {
                        score_offset = -10,
                    },
                },
            },
            keymap = {
                preset = "super-tab",
            },
            signature = { window = { border = "single" } },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    border = "single",
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 50,
                    window = { border = "single" },
                },
            },
        },
        opts_extend = { "sources.default" },
    },
}
