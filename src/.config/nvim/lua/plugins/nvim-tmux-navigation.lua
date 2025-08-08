return {
    "alexghergh/nvim-tmux-navigation",
    lazy = false,
    config = function()
        local nvim_tmux_nav = require "nvim-tmux-navigation"

        nvim_tmux_nav.setup {
            keybindings = {
                left = "<C-h>",
                down = "<C-j>",
                up = "<C-k>",
                right = "<C-l>",
                last_active = "<C-\\>",
                next = "<C-Space>",
            },
        }
    end,
}
