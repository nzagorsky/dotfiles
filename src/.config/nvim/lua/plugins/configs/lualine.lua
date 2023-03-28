require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = { left = "", right = " " }, -- 
        section_separators = { left = "", right = "" },
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
    sections = {
        lualine_a = {},
        lualine_b = { "mode" },
        lualine_c = { "diff", "filename" },
        lualine_x = { "diagnostics" },
        lualine_y = { "filetype", "location" },
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
})
