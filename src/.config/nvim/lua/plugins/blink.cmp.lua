return {
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
                },
                providers = {
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
