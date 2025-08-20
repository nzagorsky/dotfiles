return {
    "stevearc/conform.nvim",
    keys = {
        { "<C-f>", function() require("conform").format { async = true, lsp_format = "fallback" } end },
    },
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                ["bash"] = { "shfmt" },
                ["css"] = { "prettier" },
                ["go"] = { "goimports", "gofumpt" },
                ["graphql"] = { "prettier" },
                ["handlebars"] = { "prettier" },
                ["html"] = { "prettier" },
                ["javascript"] = { "prettier" },
                ["javascriptreact"] = { "prettier" },
                ["json"] = { "prettier" },
                ["jsonc"] = { "prettier" },
                ["less"] = { "prettier" },
                ["lua"] = { "stylua" },
                ["markdown"] = { "prettier" },
                ["markdown.mdx"] = { "prettier" },
                ["python"] = { "ruff_fix", "ruff_format" },
                ["scss"] = { "prettier" },
                ["sh"] = { "shfmt" },
                ["swift"] = { "swiftformat" },
                ["toml"] = { "taplo" },
                ["terraform"] = { "terraform_fmt" },
                ["typescript"] = { "prettier" },
                ["typescriptreact"] = { "prettier" },
                ["vue"] = { "prettier" },
                ["yaml"] = { "prettier" },
                ["zsh"] = { "shfmt" },
                ["*"] = { "codespell", "trim_whitespace", "typos" },
            },
        }
    end,
}
