return {
    "mason-org/mason-lspconfig.nvim",
    event = { "CursorHold", "CursorHoldI" },
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }

                vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "[g", function() vim.diagnostic.jump { count = -1, float = true } end, opts)
                vim.keymap.set("n", "]g", function() vim.diagnostic.jump { count = 1, float = true } end, opts)
            end,
        })

        local diag_signs = {
            [vim.diagnostic.severity.ERROR] = "X ",
            [vim.diagnostic.severity.WARN] = "! ",
            [vim.diagnostic.severity.HINT] = ". ",
            [vim.diagnostic.severity.INFO] = ". ",
        }

        vim.diagnostic.config {
            virtual_text = true,
            signs = {
                text = diag_signs,
            },
        }

        vim.diagnostic.config {
            virtual_text = true,
        }

        local ensure_installed = {
            "basedpyright",
            "bash-language-server",
            "cmake-language-server",
            "docker-compose-language-service",
            "dockerfile-language-server",
            "golangci-lint",
            "gopls",
            "html-lsp",
            "json-lsp",
            "kube-linter",
            "lua-language-server",
            "marksman",
            "mypy",
            "ruff",
            "rust-analyzer",
            "shfmt",
            "sqlls",
            "stylua",
            "taplo",
            "terraform-ls",
            "typescript-language-server",
            "yaml-language-server",
        }

        vim.api.nvim_create_user_command(
            "MasonInstallAll",
            function() vim.cmd("MasonInstall " .. table.concat(ensure_installed, " ")) end,
            {}
        )
    end,
}
