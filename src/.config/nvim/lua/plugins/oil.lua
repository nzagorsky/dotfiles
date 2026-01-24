return {
    "stevearc/oil.nvim",
    opts = {
        view_options = {
            show_hidden = true,
        },
    },
    dependencies = { { "echasnovski/mini.icons" } },
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Oil" },
    },
}
