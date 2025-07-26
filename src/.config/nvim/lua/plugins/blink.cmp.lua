return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "*",

    opts = {
        keymap = {
            preset = "super-tab",
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
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
}
