return {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
        require("fzf-lua").setup {
            defaults = {
                file_icons = "mini",
            },
            winopts = {
                fullscreen = true,
            },
            keymap = {
                builtin = {
                    true,
                    ["jk"] = "hide",
                },
            },
        }
    end,
    keys = {
        { "<leader>b", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>" },
        { "<leader>l", "<cmd>FzfLua lines<cr>" },
        { "<leader>f", "<cmd>FzfLua files<cr>" },
        { "<leader>c", "<cmd>FzfLua commands<cr>" },
        { "<leader>h", "<cmd>FzfLua help_tags<cr>" },
        { "<leader>t", "<cmd>FzfLua tags<cr>" },
        { "<leader>a", "<cmd>FzfLua grep<cr>" },
        { "<leader>A", "<cmd>FzfLua grep_cword<cr>" },
        { "<leader>:", "<cmd>FzfLua command_history<cr>" },
        { "<leader>dw", "<cmd>FzfLua lsp_document_diagnostics<cr>" },
        { "gr", "<cmd>FzfLua lsp_references<cr>" },
    },
}
