local M = {
    config = function()
        local lspconfig = require "lspconfig"
        local util = require "lspconfig.util"
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }

                vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
            end,
        })

        local signs = {
            Error = "X ",
            Warn = "! ",
            Hint = ". ",
            Info = ". ",
        }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, {
                text = icon,
                texthl = hl,
                numhl = "",
            })
        end

        vim.diagnostic.config {
            virtual_text = true,
        }

        local default_opts = {
            capabilities = capabilities,
        }

        lspconfig.basedpyright.setup {
            capabilities = capabilities,
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
        }
        lspconfig.lua_ls.setup {
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
        lspconfig.ts_ls.setup {
            capabilities = capabilities,
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
                "astro",
            },
        }

        lspconfig.gopls.setup {
            capabilities = capabilities,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    },
                },
            },
        }
        lspconfig.rust_analyzer.setup(default_opts)
        lspconfig.ansiblels.setup(default_opts)
        lspconfig.bashls.setup(default_opts)
        lspconfig.cmake.setup(default_opts)
        lspconfig.html.setup(default_opts)
        lspconfig.marksman.setup(default_opts)
        lspconfig.sqlls.setup(default_opts)
        lspconfig.terraformls.setup(default_opts)
        lspconfig.dockerls.setup(default_opts)
        lspconfig.docker_compose_language_service.setup(default_opts)

        lspconfig.sourcekit.setup {
            capabilities = capabilities,
            cmd = {
                "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
            },
            root_dir = function(filename, _)
                return util.root_pattern "buildServer.json"(filename)
                    or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
                    or util.find_git_ancestor(filename)
                    or util.root_pattern "Package.swift"(filename)
            end,
        }
    end,
}
return M
