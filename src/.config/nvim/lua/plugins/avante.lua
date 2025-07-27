return {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    version = false,

    ---@module 'avante'
    ---@type avante.Config
    opts = {
        provider = "openai",
        providers = {},
        behaviour = {
            enable_fastapply = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = true,
        },
        mappings = {
            --- @class AvanteConflictMappings
            diff = {
                ours = "co",
                theirs = "ct",
                all_theirs = "ca",
                both = "cb",
                cursor = "cc",
                next = "]x",
                prev = "[x",
            },
            suggestion = {
                accept = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
            jump = {
                next = "]]",
                prev = "[[",
            },
            submit = {
                normal = "<CR>",
                insert = "<C-s>",
            },
            cancel = {
                normal = { "<C-c>", "<Esc>", "q" },
                insert = { "<C-c>" },
            },
            toggle = {
                default = "<leader>at",
                hint = "<leader>ah",
                suggestion = "<leader>as",
                repomap = "<leader>aR",
            },
            sidebar = {
                apply_all = "A",
                apply_cursor = "a",
                retry_user_request = "r",
                edit_user_request = "e",
                switch_windows = "<Tab>",
                reverse_switch_windows = "<S-Tab>",
                remove_file = "d",
                add_file = "@",
                close = { "<Esc>", "q", "jk" },
                close_from_input = { normal = "jk", insert = "jk" },
            },
        },
        selector = {
            --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
            --- @type avante.SelectorProvider
            provider = "fzf_lua",
            -- Options override for custom providers
            provider_opts = {},
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",

        --- The below dependencies are optional,
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
            -- Make sure to set this up properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
