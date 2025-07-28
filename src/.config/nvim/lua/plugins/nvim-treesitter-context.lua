return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("treesitter-context").setup() end,
}
