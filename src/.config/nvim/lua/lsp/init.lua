vim.lsp.config("basedpyright", {
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        basedpyright = {
            analysis = {
                -- autoSearchPaths = true,
                -- useLibraryCodeForTypes = true,
                -- autoImportCompletions = true,
                -- logLevel = "Warning",
                -- diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
            },
        },
    },
})

vim.lsp.config("lua_ls.setup ", {
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                    "hs",
                },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
            format = {
                enable = false,
            },
        },
    },
})

vim.lsp.config("ts_ls", {
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "astro",
    },
})

vim.lsp.config("gopls", {
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
})

vim.lsp.config("yamlls", {
    capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    filetypes = { "yaml" },
    settings = {
        yaml = {
            schemas = {
                kubernetes = "k8s-*.yaml",
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
                ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/external-secrets.io/externalsecret_v1beta1.json"] = "external-secret.{yml,yaml}",
            },
        },
    },
})
