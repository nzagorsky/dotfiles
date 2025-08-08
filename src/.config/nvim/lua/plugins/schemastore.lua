return {
    "b0o/schemastore.nvim",
    ft = { "yaml", "yml", "json", "jsonc", "helm" },
    config = function()
        vim.lsp.config("jsonls", {
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        vim.lsp.config("yamlls", {
            settings = {
                yaml = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    schemas = require("schemastore").yaml.schemas(),
                },
            },
        })
    end,
}
