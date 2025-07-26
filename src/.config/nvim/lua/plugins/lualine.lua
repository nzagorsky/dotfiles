return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                "mode",
                { "filename", path = 1 },
                "diff",
            },
            lualine_x = { "diagnostics", "%y %l/%L" },
            lualine_y = {},
            lualine_z = {},
        }

        require("lualine").setup {
            options = {
                icons_enabled = false,
                component_separators = {
                    left = " ",
                    right = " ",
                }, -- 
                section_separators = {
                    left = " ",
                    right = " ",
                },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = sections,
            inactive_sections = sections,
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        }
    end,
}
