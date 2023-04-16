local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                light_style = "day", -- The theme is used when the background is set to light
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "transparent", -- style for sidebars, see below
                    floats = "transparent", -- style for floating windows
                },
                sidebars = { "qf", "help", "NvimTree" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
                day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
                hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
                dim_inactive = true, -- dims inactive windows
                lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

                --- You can override specific color groups to use other groups or a hex color
                --- function will be called with a ColorScheme table
                ---@param colors ColorScheme
                on_colors = function(colors) end,

                --- You can override specific highlights to use other groups or a hex color
                --- function will be called with a Highlights and ColorScheme table
                ---@param highlights Highlights
                ---@param colors ColorScheme
                on_highlights = function(highlights, colors) end,
            }
            vim.cmd [[colorscheme tokyonight-night]]
        end,
    },

    {
        "kyazdani42/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },

        init = function()
            vim.api.nvim_set_keymap("n", "<c-n>", ":NvimTreeToggle<cr>", { noremap = true })
        end,
        config = function()
            local nvimtree = require "nvim-tree"
            local options = {
                filters = {
                    dotfiles = false,
                },
                disable_netrw = true,
                hijack_netrw = true,
                open_on_tab = false,
                hijack_cursor = true,
                hijack_unnamed_buffer_when_opening = false,
                update_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_cwd = false,
                },
                view = {
                    side = "left",
                    width = 30,
                },
                git = {
                    enable = false,
                    ignore = false,
                },
                actions = {
                    open_file = {
                        resize_window = true,
                    },
                },
                renderer = {
                    root_folder_label = false,
                    indent_markers = {
                        enable = false,
                    },
                },
            }

            nvimtree.setup(options)
        end,
        dependencies = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
    },

    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            local nvim_tmux_nav = require "nvim-tmux-navigation"

            vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
            vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
            vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
        end,
    },

    "nvim-lua/plenary.nvim",

    {
        "folke/which-key.nvim",
        keys = { "<leader>", '"', "'", "`", "c", "v" },
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            local current_buffer_search = function()
                require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end

            -- See `:help telescope.builtin`
            vim.keymap.set("n", "<leader>?", function()
                require("telescope.builtin").oldfiles()
            end, { remap = false })

            vim.keymap.set("n", "<leader>b", function()
                require("telescope.builtin").buffers()
            end, { remap = false })

            vim.keymap.set("n", "<leader>/", current_buffer_search, { remap = true })

            vim.keymap.set("n", "<leader>f", function()
                require("telescope.builtin").find_files { hidden = true }
            end, { remap = false })

            vim.keymap.set("n", "<leader>h", function()
                require("telescope.builtin").help_tags()
            end, { remap = false })

            vim.keymap.set("n", "<leader>t", function()
                require("telescope.builtin").tags { fname_width = 50, show_line = false }
            end, { remap = false })

            vim.keymap.set("n", "<leader>a", function()
                require("telescope.builtin").grep_string { search = "" }
            end, { remap = false })

            vim.keymap.set("n", "<leader>A", function()
                require("telescope.builtin").grep_string()
            end, { remap = false })

            vim.keymap.set("n", "<leader>d", function()
                require("telescope.builtin").diagnostics { bufnr = 0 }
            end, { remap = false })

            vim.keymap.set("n", "<leader>dw", function()
                require("telescope.builtin").diagnostics()
            end, { remap = false })

            vim.keymap.set("n", "gr", function()
                require("telescope.builtin").lsp_references {
                    fname_width = 50,
                    include_declaration = false,
                    jump_type = "never",
                }
            end, { remap = false })
        end,
        config = function()
            local actions = require "telescope.actions"
            local telescope_mappings = {
                ["jk"] = actions.close,
                ["<leader>q"] = actions.close,
                ["<Esc>"] = actions.close,
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            }

            require("telescope").setup {
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git" },
                    vimgrep_arguments = {
                        "rg",
                        "-L",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                    },
                    mappings = {
                        i = telescope_mappings,
                        n = telescope_mappings,
                    },
                    sorting_strategy = "descending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "bottom",
                            preview_width = 0.35,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 230,
                        height = 40,
                        preview_cutoff = 120,
                    },
                },
            }
        end,
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason-lspconfig").setup {
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "ansiblels",
                    "bashls",
                    "cmake",
                    "dockerls",
                    "docker_compose_language_service",
                    "gopls",
                    "html",
                    "jsonls",
                    "marksman",
                    "sqlls",
                    "terraformls",
                    "vimls",
                },
            }

            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                    }
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {
                                        "vim",
                                    },
                                },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                                format = {
                                    enable = false,
                                },
                            },
                        },
                    }
                end,

                ["pyright"] = function()
                    local pyright_capabilities = require("cmp_nvim_lsp").default_capabilities()
                    -- local pyright_capabilities = vim.lsp.protocol.make_client_capabilities()
                    -- pyright_capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

                    require("lspconfig").pyright.setup {
                        capabilities = pyright_capabilities,
                        before_init = function(_, config)
                            config.settings = {
                                python = {
                                    analysis = {
                                        autoSearchPaths = true,
                                        useLibraryCodeForTypes = true,
                                        autoImportCompletions = true,
                                        logLevel = "Warning",
                                        diagnosticMode = "openFilesOnly",
                                    },
                                },
                            }
                        end,
                    }
                end,
            }
        end,
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
            -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- -- Enable completion triggered by <c-x><c-o>
                    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = {
                        buffer = ev.buf,
                    }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.signature_help, opts)
                    -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
                    -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
                    -- vim.keymap.set("n", "<space>wl", function()
                    -- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    -- end, opts)
                    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<F3>", function()
                        vim.lsp.buf.format {
                            async = false,
                        }
                    end, opts)
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
            vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
            vim.api.nvim_create_autocmd("CursorHold", {
                command = "silent! lua vim.lsp.buf.document_highlight()",
                buffer = bufnr,
                group = "lsp_document_highlight",
                desc = "Document Highlight",
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                command = "silent! lua vim.lsp.buf.clear_references()",
                buffer = bufnr,
                group = "lsp_document_highlight",
                desc = "Clear All the References",
            })
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require "null-ls"

            local sources = {
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.formatting.cmake_format,
                null_ls.builtins.diagnostics.hadolint,
                null_ls.builtins.diagnostics.ansiblelint,
            }

            null_ls.setup {
                sources = sources,
            }
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        config = function()
            -- Set up nvim-cmp.
            local cmp = require "cmp"

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
            end

            local max_item_count = 10

            local all_buffers_source = {
                name = "buffer",
                max_item_count = max_item_count,
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end,
                },
            }

            cmp.setup {
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },

                sources = cmp.config.sources {
                    { name = "nvim_lsp", max_item_count = max_item_count },
                    { name = "path", max_item_count = max_item_count },
                    all_buffers_source,
                    -- { name = "vsnip" }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                },
            }

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources {
                    { name = "path" },
                    { name = "cmdline" },
                },
            })
        end,

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
    },

    {
        "ray-x/lsp_signature.nvim",
        config = function()
            local signature_config = {
                debug = true,
                hint_enable = false,
                handler_opts = { border = "rounded" },
                max_width = 80,
            }
            require("lsp_signature").setup(signature_config)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                -- one of "all", "maintained" (parsers with maintainers),
                -- or a list of languages
                ensure_installed = {
                    "bash",
                    "cmake",
                    "comment",
                    "dockerfile",
                    "elixir",
                    "gitignore",
                    "go",
                    "html",
                    "htmldjango",
                    "javascript",
                    "lua",
                    "python",
                    "vim",
                    "yaml",
                },
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },
            }
        end,
        build = ":TSUpdate",
    },

    {
        "ThePrimeagen/refactoring.nvim",
        config = function()
            require("refactoring").setup {
                prompt_func_return_type = {
                    go = false,
                    java = false,
                    cpp = false,
                    c = false,
                    h = false,
                    hpp = false,
                    cxx = false,
                },
                prompt_func_param_type = {
                    go = false,
                    java = false,
                    cpp = false,
                    c = false,
                    h = false,
                    hpp = false,
                    cxx = false,
                },
                printf_statements = {},
                print_var_statements = {},
            }
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    "mode",
                    { "filename", path = 1 },
                    "diff",
                },
                lualine_x = { "diagnostics", "%y %l/%L" },
                lualine_y = {},
                lualine_z = {},
            }

            require("lualine").setup {
                options = {
                    icons_enabled = false,
                    theme = "auto",
                    component_separators = {
                        left = " ",
                        right = " ",
                    }, -- 
                    section_separators = {
                        left = " ",
                        right = " ",
                    },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = sections,
                inactive_sections = sections,
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            }
        end,
    },

    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    { "tpope/vim-rsi" },

    {
        "numToStr/Comment.nvim",
        keys = { "gc", "gb" },
        config = function()
            require("Comment").setup {
                toggler = {
                    ---Line-comment toggle keymap
                    line = "gc",
                    ---Block-comment toggle keymap
                    block = "gb",
                },
            }
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        branch = "main",
        config = function()
            require("toggleterm").setup {
                size = 30,
                open_mapping = [[<a-j>]],
                hide_numbers = true, -- hide the number column in toggleterm buffers
                shade_terminals = true,
                shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
                terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
                persist_size = true,
                -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
                close_on_exit = true, -- close the terminal window when the process exits
                shell = vim.o.shell, -- change the default shell
                -- This field is only relevant if direction is set to 'float'
                float_opts = {
                    -- The border key is *almost* the same as 'nvim_open_win'
                    -- see :h nvim_open_win for details on borders however
                    -- the 'curved' border is a custom border type
                    -- not natively supported but implemented in this plugin.
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            }
        end,
    },

    {
        "ludovicchabant/vim-gutentags",
    },

    {
        "tpope/vim-fugitive",
        config = function()
            vim.cmd [[
                noremap <Leader>gs :Git<CR>
                noremap <Leader>gc :Git commit<CR>
                noremap <Leader>gpush :Git push<CR>
                noremap <Leader>gpull :Git pull<CR>
                noremap <Leader>gb :Git blame<CR>
                noremap <Leader>gd :Gvdiff<CR>
                noremap <Leader>gr :GRemove<CR>
            ]]
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                    })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                    })
                end,
                signs = {
                    add = {
                        text = "│",
                    },
                    change = {
                        text = "│",
                    },
                    delete = {
                        text = "_",
                    },
                    topdelete = {
                        text = "‾",
                    },
                    changedelete = {
                        text = "~",
                    },
                    untracked = {
                        text = "┆",
                    },
                },
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = "single",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                yadm = {
                    enable = false,
                },
            }
        end,
    },

    {
        "tpope/vim-dadbod",
        config = function()
            vim.cmd [[
                " Dadbod
                let g:db_ui_winwidth = 30
                let g:dbs = {
                \  'local': 'postgres://toltenos:@localhost:5432/postgres'
                \ }
            ]]
        end,
        lazy = true,
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = { "tpope/vim-dadbod" },
        cmd = { "DBUI" },
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end,
    },
}

local vim = vim
local g = vim.g
local o = vim.o
local set = vim.opt
local vapi = vim.api

set.lazyredraw = true
set.scrolloff = 1
set.textwidth = 0 -- Do not break the line while typing
set.showcmd = true -- Show the (partial) command as it’s being typed

set.smarttab = true
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4

set.incsearch = true
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.infercase = true
set.showmatch = true

set.splitbelow = true
set.splitright = true

set.wildmenu = true

set.foldenable = true
set.foldmethod = "indent"
set.foldlevelstart = 99
set.foldnestmax = 10 -- deepest fold is 10 levels

vim.cmd [[
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
syntax on
filetype indent on
filetype plugin on
filetype plugin indent on " Enable filetype plugins and indention

set nostartofline " Don’t reset cursor to start of line when moving around.

set noerrorbells " No annoying errors
set novisualbell


function! MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

" Creating parent folders if they doesn't exist on buffer save.
augroup AutomaticDirectoryCreation
    autocmd!
    autocmd BufWritePre * :call MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


    ]]

-- dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- Settings
o.clipboard = "unnamedplus"
o.autoread = true -- detect when a file is changed
o.signcolumn = "yes" --  no more text shifting
o.hidden = true --  buffers
o.wrap = true
o.swapfile = false
o.undofile = true
o.undodir = vim.fn.expand "~" .. "/.cache/nvim/undo"
o.backupdir = vim.fn.expand "~" .. "/.cache/nvim/backup"
o.directory = vim.fn.expand "~" .. "/.cache/nvim/dir"
o.history = 1000
o.title = true
o.titleold = "Terminal"
o.titlestring = "%F"
o.cmdheight = 1
o.shortmess = "aoOtIWcFs"
o.updatetime = 250

g.mapleader = " "

vapi.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true })
vapi.nvim_set_keymap("c", "jk", "<Esc>", { noremap = true })
vapi.nvim_set_keymap("t", "jk", [[<C-\><C-n>]], { noremap = true })

vapi.nvim_set_keymap("i", "ол", "<Esc>", { noremap = true })
vapi.nvim_set_keymap("c", "ол", "<Esc>", { noremap = true })
vapi.nvim_set_keymap("t", "ол", [[<C-\><C-n>]], { noremap = true })

vapi.nvim_set_keymap("n", "j", "gj", {})
vapi.nvim_set_keymap("n", "k", "gk", {})

vapi.nvim_set_keymap("n", "<leader><leader>", "V", { noremap = true })
vapi.nvim_set_keymap("n", "<leader>w", ":w<cr>", { noremap = true })
vapi.nvim_set_keymap("n", "<leader>q", ":q<cr>", { noremap = true })
vapi.nvim_set_keymap("n", "<leader>kb", ":bd<cr>", { noremap = true })
vapi.nvim_set_keymap("n", "Y", "y$", { noremap = true })

vapi.nvim_set_keymap("n", "<a-x>", ":Commands<cr>", { noremap = true })

vapi.nvim_set_keymap("n", "<c-h>", "<C-w>h", { noremap = true })
vapi.nvim_set_keymap("n", "<c-j>", "<C-w>j", { noremap = true })
vapi.nvim_set_keymap("n", "<c-k>", "<C-w>k", { noremap = true })
vapi.nvim_set_keymap("n", "<c-l>", "<C-w>l", { noremap = true })

vapi.nvim_set_keymap("t", "<c-h>", [[<C-\><C-n><C-w>h]], { noremap = true })
vapi.nvim_set_keymap("t", "<c-j>", [[<C-\><C-n><C-w>j]], { noremap = true })
vapi.nvim_set_keymap("t", "<c-k>", [[<C-\><C-n><C-w>k]], { noremap = true })
vapi.nvim_set_keymap("t", "<c-l>", [[<C-\><C-n><C-w>l]], { noremap = true })

vapi.nvim_set_keymap("n", "<s-t>", ":tab split<cr>", { noremap = true, silent = true })
vapi.nvim_set_keymap("n", "<c-t>", ":tabnew<cr>", { noremap = true, silent = true })
vapi.nvim_set_keymap("n", "<cr>", ":nohlsearch<cr><cr>", { noremap = true, silent = true })

vapi.nvim_set_keymap("n", "<leader>S", [[:%s/\s\+$//<cr>:let @/=''<CR>]], { noremap = true, silent = true })

vapi.nvim_set_keymap("c", "w!!", "w !sudo tee % > /dev/null", {})

vapi.nvim_set_keymap("n", "gev", ":e $MYVIMRC<cr>", { noremap = true })
vapi.nvim_set_keymap("n", "gsv", ":so $MYVIMRC <bar> bufdo e<CR>", { noremap = true })

if os.getenv "TMUX" == nil then
    for num = 1, 10 do
        vapi.nvim_set_keymap("n", string.format("<A-%s>", num), string.format("<Esc>%sgt", num), { noremap = true })
    end

    for num = 1, 10 do
        vapi.nvim_set_keymap("i", string.format("<A-%s>", num), string.format("<Esc>%sgt", num), { noremap = true })
    end

    for num = 1, 10 do
        vapi.nvim_set_keymap(
            "t",
            string.format("<A-%s>", num),
            string.format([[<C-\><C-n>%sgt]], num),
            { noremap = true }
        )
    end

    vapi.nvim_set_keymap("n", "<A-h>", "<Esc>:tabprevious<CR>", { noremap = true })
    vapi.nvim_set_keymap("i", "<A-h>", "<Esc>:tabprevious<CR>", { noremap = true })
    vapi.nvim_set_keymap("t", "<A-h>", [[<C-\><C-n>:tabprevious<CR>]], { noremap = true })

    vapi.nvim_set_keymap("n", "<A-l>", "<Esc>:tabnext<CR>", { noremap = true })
    vapi.nvim_set_keymap("i", "<A-l>", "<Esc>:tabnext<CR>", { noremap = true })
    vapi.nvim_set_keymap("t", "<A-l>", [[<C-\><C-n>:tabnext<CR>]], { noremap = true })
end
