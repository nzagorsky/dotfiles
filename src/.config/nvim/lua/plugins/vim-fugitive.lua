return {
    "tpope/vim-fugitive",
    event = { "InsertEnter", "CmdlineEnter" },
    keys = {
        { "<leader>gs", "<cmd>Git<cr>", desc = "Status" },
        { "<leader>gc", "<cmd>Git commit<cr>" },
        { "<leader>gpush", "<cmd>Git push<cr>" },
        { "<leader>gpull", "<cmd>Git pull<cr>" },
        { "<leader>gb", "<cmd>Git blame<cr>" },
        { "<leader>gd", "<cmd>Gvdiff<cr>" },
        { "<leader>gr", "<cmd>GRemove<cr>" },
    },
}
