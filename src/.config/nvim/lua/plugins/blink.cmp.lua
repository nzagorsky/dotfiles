return {
    {
        "saghen/blink.cmp",
        dependencies = {
            { "rafamadriz/friendly-snippets" },
            { "saghen/blink.compat" },
            {
                "supermaven-inc/supermaven-nvim",
                opts = {
                    keymaps = {
                        accept_suggestion = nil,
                    },
                    disable_inline_completion = true,
                    ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
                },
            },
        },
        event = { "InsertEnter", "CmdlineEnter" },
        version = "1.*",

        opts = {
            sources = {
                default = {
                    "lazydev",
                    "supermaven",
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    lsp = {
                        score_offset = 10,
                    },
                    buffer = {
                        score_offset = -10,
                    },
                    supermaven = {
                        name = "supermaven",
                        module = "blink.compat.source",
                        score_offset = 100,
                        async = true,
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
