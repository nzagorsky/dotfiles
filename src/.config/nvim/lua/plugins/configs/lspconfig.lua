local M = {
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
        vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "]g", vim.diagnostic.goto_next)

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<F3>", function() vim.lsp.buf.format { async = false } end, opts)
            end,
        })

        local signs = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " ",
        }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, {
                text = icon,
                texthl = hl,
                numhl = "",
            })
        end

        local _border = "single"
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = _border,
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = _border,
        })

        vim.diagnostic.config {
            float = {
                border = _border,
            },
            virtual_text = false,
            update_in_insert = false,
        }

        require("lspconfig.ui.windows").default_options = {
            border = _border,
        }

        vim.cmd [[autocmd CursorHold * silent! lua vim.diagnostic.open_float(nil, {focus=false})]]

        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_clear_autocmds { group = "lsp_document_highlight" }
        vim.api.nvim_create_autocmd("CursorHold", {
            command = "silent! lua vim.lsp.buf.document_highlight()",
            group = "lsp_document_highlight",
            desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            command = "silent! lua vim.lsp.buf.clear_references()",
            group = "lsp_document_highlight",
            desc = "Clear All the References",
        })

        local default_opts = {
            capabilities = capabilities,
        }
        require("lspconfig").pyright.setup {
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        autoImportCompletions = true,
                        logLevel = "Warning",
                        diagnosticMode = "openFilesOnly",
                    },
                },
            },
        }

        require("lspconfig").lua_ls.setup {
            capabilities = capabilities,
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
                            [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
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
        }

        require("lspconfig").gopls.setup(default_opts)
        require("lspconfig").ansiblels.setup(default_opts)
        require("lspconfig").bashls.setup(default_opts)
        require("lspconfig").cmake.setup(default_opts)
        require("lspconfig").dockerls.setup(default_opts)
        require("lspconfig").html.setup(default_opts)
        require("lspconfig").marksman.setup(default_opts)
        require("lspconfig").sqlls.setup(default_opts)
        require("lspconfig").terraformls.setup(default_opts)
    end,
}
return M
