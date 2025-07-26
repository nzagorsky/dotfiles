return {
    "catppuccin/nvim",
    config = function()
        require("catppuccin").setup {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true, -- disables setting the background color.
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
