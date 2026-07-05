return {
    "romus204/tree-sitter-manager.nvim",
    event = "VeryLazy",
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    config = function()
        require("tree-sitter-manager").setup {
            auto_install = false, -- auto-install when a new filetype is encountered
        }
    end,
}
