return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            float = {
                transparent = true,
                solid = true,
            },
            color_overrides = {
                mocha = {
                    base = "#181818",
                    crust = "#111111",
                    mantle = "#161616",
                },
            },
        }
        vim.cmd.colorscheme "catppuccin-mocha"
    end,
}
