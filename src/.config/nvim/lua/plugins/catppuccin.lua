return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup {
            flavour = "latte", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            -- color_overrides = {
            --     mocha = {
            --         base = "#181818",
            --         crust = "#111111",
            --         mantle = "#161616",
            --     },
            -- },
        }
        vim.cmd.colorscheme "catppuccin-latte"
    end,
}
