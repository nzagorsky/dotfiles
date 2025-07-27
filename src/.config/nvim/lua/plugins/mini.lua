return {
    "echasnovski/mini.nvim",
    event = "BufWinEnter",
    config = function()
        require("mini.comment").setup {}
        require("mini.pairs").setup {}
    end,
}
