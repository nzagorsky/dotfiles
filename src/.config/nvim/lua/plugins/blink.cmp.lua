return {
    {
        "saghen/blink.compat",
        -- use v2.* for blink.cmp v1.*
        version = "2.*",
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            {
                "fang2hou/blink-copilot",
                opts = {
                    debounce = 100,
                },
            },
            { "rafamadriz/friendly-snippets" },
        },
        event = { "InsertEnter", "CmdlineEnter" },
        version = "1.*",

        opts = {
            sources = {
                default = {
                    "lazydev",
                    "lsp",
                    "copilot",
                    "path",
                    "snippets",
                    -- "avante_commands",
                    -- "avante_mentions",
                    -- "avante_shortcuts",
                    -- "avante_files",
                },
                providers = {
                    -- avante_commands = {
                    --     name = "avante_commands",
                    --     module = "blink.compat.source",
                    --     score_offset = 90, -- show at a higher priority than lsp
                    --     opts = {},
                    -- },
                    -- avante_files = {
                    --     name = "avante_files",
                    --     module = "blink.compat.source",
                    --     score_offset = 100, -- show at a higher priority than lsp
                    --     opts = {},
                    -- },
                    -- avante_mentions = {
                    --     name = "avante_mentions",
                    --     module = "blink.compat.source",
                    --     score_offset = 1000, -- show at a higher priority than lsp
                    --     opts = {},
                    -- },
                    -- avante_shortcuts = {
                    --     name = "avante_shortcuts",
                    --     module = "blink.compat.source",
                    --     score_offset = 1000, -- show at a higher priority than lsp
                    --     opts = {},
                    -- },
                    lsp = {
                        score_offset = 10,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = -100,
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
