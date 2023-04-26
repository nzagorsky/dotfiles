vim.g.mapleader = " "
vim.opt.lazyredraw = true
vim.opt.scrolloff = 1
vim.opt.textwidth = 0 -- Do not break the line while typing
vim.opt.showcmd = true -- Show the (partial) command as it’s being typed

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.showmatch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wildmenu = true

vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 10 -- deepest fold is 10 levels
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.startofline = false

-- Creating parent folders if they doesn't exist on buffer save.
vim.cmd [[
function! MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup AutomaticDirectoryCreation
    autocmd!
    autocmd BufWritePre * :call MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
]]

-- dont list quickfix buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function() vim.opt_local.buflisted = false end,
})

-- Settings
vim.o.clipboard = "unnamedplus"
vim.o.autoread = true -- detect when a file is changed
vim.o.signcolumn = "yes" --  no more text shifting
vim.o.hidden = true --  buffers
vim.o.wrap = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand "~" .. "/.cache/nvim/undo"
vim.o.backupdir = vim.fn.expand "~" .. "/.cache/nvim/backup"
vim.o.directory = vim.fn.expand "~" .. "/.cache/nvim/dir"
vim.o.history = 1000
vim.o.title = true
vim.o.titleold = "Terminal"
vim.o.titlestring = "%F"
vim.o.cmdheight = 1
vim.o.shortmess = "aoOtIWcFs"
vim.o.updatetime = 250

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

--- PLUGINS
require("lazy").setup {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup {
                style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                light_style = "day", -- The theme is used when the background is set to light
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    sidebars = "transparent", -- style for sidebars, see below
                    floats = "transparent", -- style for floating windows
                },
                sidebars = { "qf", "help", "NvimTree" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
                day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
                hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
                dim_inactive = false, -- dims inactive windows
                lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
            }
            vim.cmd [[colorscheme tokyonight-night]]
        end,
    },

    {
        "kyazdani42/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        keys = {
            { "<c-n>", ":NvimTreeToggle<cr>" },
        },
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
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>?",
                function() require("telescope.builtin").oldfiles() end,
            },

            {
                "<leader>b",
                function() require("telescope.builtin").buffers { sort_mru = true } end,
            },

            {
                "<leader>/",
                function() require("telescope.builtin").current_buffer_fuzzy_find() end,
            },

            {
                "<leader>l",
                function()
                    require("telescope.builtin").live_grep {
                        prompt_title = "find string in open buffers...",
                        grep_open_files = true,
                    }
                end,
            },

            {
                "<leader>f",
                function() require("telescope.builtin").find_files { hidden = true } end,
            },

            {
                "<leader>h",
                function() require("telescope.builtin").help_tags() end,
            },

            {
                "<leader>t",
                function() require("telescope.builtin").tags { fname_width = 50, show_line = false } end,
            },

            {
                "<leader>a",
                function()
                    require("telescope.builtin").grep_string {
                        search = vim.fn.input { prompt = "Search string: ", default = "" },
                        disable_coordinates = true,
                    }
                end,
            },

            {
                "<leader>A",
                function() require("telescope.builtin").grep_string { disable_coordinates = true } end,
            },

            {
                "<leader>d",
                function() require("telescope.builtin").diagnostics { bufnr = 0 } end,
            },

            {
                "<leader>dw",
                function() require("telescope.builtin").diagnostics() end,
            },

            {
                "gr",
                function()
                    require("telescope.builtin").lsp_references {
                        fname_width = 50,
                        include_declaration = false,
                        jump_type = "never",
                    }
                end,
            },
        },
        config = function()
            pcall(require("telescope").load_extension, "fzf")
            local actions = require "telescope.actions"
            local telescope_mappings = {
                ["jk"] = actions.close,
                ["<leader>q"] = actions.close,
                ["<Esc>"] = actions.close,
                ["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
            }

            require("telescope").setup {
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git" },
                    -- vimgrep_arguments = {
                    --     "rg",
                    --     "--column",
                    --     "--line-number",
                    --     "--no-heading",
                    --     "--color=never",
                    --     "--smart-case",
                    --     "--follow",
                    --     "--hidden",
                    --     "--trim",
                    -- },
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
                pickers = {

                    find_files = {
                        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
                    },
                    grep_string = {
                        only_sort_text = true,
                    },
                    tags = {
                        only_sort_tags = true,
                    },
                    buffers = {
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                            },
                        },
                    },
                },
            }
        end,
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable "make" == 1 end,
    },

    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = function()
            require("mason").setup()

            local ensure_installed = {
                "lua-language-server",
                "pyright",
                "ansible-language-server",
                "bash-language-server",
                "cmake-language-server",
                "dockerfile-language-server",
                "docker-compose-language-service",
                "gopls",
                "yaml-language-server",
                "html-lsp",
                "json-lsp",
                "marksman",
                "sqlls",
                "terraform-ls",
            }
            vim.api.nvim_create_user_command(
                "MasonInstallAll",
                function() vim.cmd("MasonInstall " .. table.concat(ensure_installed, " ")) end,
                {}
            )
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]g", vim.diagnostic.goto_next)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = {
                        buffer = ev.buf,
                    }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
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
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            { "ThePrimeagen/refactoring.nvim" },
        },
        config = function()
            local null_ls = require "null-ls"

            local sources = {
                null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.diagnostics.ansiblelint,
                null_ls.builtins.diagnostics.hadolint,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.cmake_format,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.mypy,
            }

            null_ls.setup {
                sources = sources,
            }
        end,
    },
    {
        "ThePrimeagen/refactoring.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function() require("refactoring").setup {} end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            -- Set up nvim-cmp.
            local cmp = require "cmp"

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
            end

            local max_item_count = 30

            local all_buffers_source = {
                name = "buffer",
                max_item_count = max_item_count,
                option = {
                    get_bufnrs = function() return vim.api.nvim_list_bufs() end,
                },
            }

            cmp.setup {
                preselect = cmp.PreselectMode.None,
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },

                sources = cmp.config.sources {
                    { name = "nvim_lsp", max_item_count = max_item_count * 2 },
                    all_buffers_source,
                    { name = "path", max_item_count = max_item_count },
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
                    { name = "nvim_lua", max_item_count = max_item_count },
                },
            })
        end,

        dependencies = {
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },

                config = function(_, opts)
                    require("nvim-autopairs").setup {}

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
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
                    "dockerfile",
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
                    theme = "tokyonight",
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
        keys = {
            { "<a-j>", "<cmd>ToggleTerm<cr>" },
        },
        branch = "main",
        config = function()
            require("toggleterm").setup {
                size = 30,
                open_mapping = [[<a-j>]],
                hide_numbers = true, -- hide the number column in toggleterm buffers
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
                terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
                shade_terminals = true,
                shading_factor = -30,
                persist_size = true,
                close_on_exit = true, -- close the terminal window when the process exits
                shell = vim.o.shell, -- change the default shell
                direction = "horizontal",
                float_opts = { -- This field is only relevant if direction is set to 'float'
                    border = "curved",
                },
            }
        end,
    },

    {
        "ludovicchabant/vim-gutentags",
    },

    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gs", "<cmd>Git<cr>" },
            { "<leader>gc", "<cmd>Git commit<cr>" },
            { "<leader>gpush", "<cmd>Git push<cr>" },
            { "<leader>gpull", "<cmd>Git pull<cr>" },
            { "<leader>gb", "<cmd>Git blame<cr>" },
            { "<leader>gd", "<cmd>Gvdiff<cr>" },
            { "<leader>gr", "<cmd>GRemove<cr>" },
        },
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
                        if vim.wo.diff then return "]c" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                    })

                    map("n", "[c", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end, {
                        expr = true,
                    })
                end,
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
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
                current_line_blame_formatter = "   <author>, <author_time:%Y-%m-%d> - <summary>",
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
            vim.g.db_ui_winwidth = 30
            vim.g.dbs = {
                localhost = "postgres://toltenos:@localhost:5432/postgres",
            }
        end,
        lazy = true,
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = { "tpope/vim-dadbod" },
        cmd = { "DBUI" },
    },
}

vim.keymap.set("i", "jk", "<Esc>", { remap = false })
vim.keymap.set("c", "jk", "<Esc>", { remap = false })
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { remap = false })

vim.keymap.set("i", "ол", "<Esc>", { remap = false })
vim.keymap.set("c", "ол", "<Esc>", { remap = false })
vim.keymap.set("t", "ол", [[<C-\><C-n>]], { remap = false })

vim.keymap.set("n", "j", "gj", {})
vim.keymap.set("n", "k", "gk", {})

vim.keymap.set("n", "<leader><leader>", "V", { remap = false })
vim.keymap.set("n", "<leader>w", ":w<cr>", { remap = false })
vim.keymap.set("n", "<leader>q", ":q<cr>", { remap = false })
vim.keymap.set("n", "<leader>kb", ":bd<cr>", { remap = false })
vim.keymap.set("n", "Y", "y$", { remap = false })

vim.keymap.set("n", "<a-x>", ":Commands<cr>", { remap = false })

vim.keymap.set("n", "<c-h>", "<C-w>h", { remap = false })
vim.keymap.set("n", "<c-j>", "<C-w>j", { remap = false })
vim.keymap.set("n", "<c-k>", "<C-w>k", { remap = false })
vim.keymap.set("n", "<c-l>", "<C-w>l", { remap = false })

vim.keymap.set("t", "<c-h>", [[<C-\><C-n><C-w>h]], { remap = false })
vim.keymap.set("t", "<c-j>", [[<C-\><C-n><C-w>j]], { remap = false })
vim.keymap.set("t", "<c-k>", [[<C-\><C-n><C-w>k]], { remap = false })
vim.keymap.set("t", "<c-l>", [[<C-\><C-n><C-w>l]], { remap = false })

vim.keymap.set("n", "<s-t>", ":tab split<cr>", { remap = false, silent = true })
vim.keymap.set("n", "<c-t>", ":tabnew<cr>", { remap = false, silent = true })
vim.keymap.set("n", "<cr>", ":nohlsearch<cr><cr>", { remap = false, silent = true })

vim.keymap.set("n", "<leader>S", [[:%s/\s\+$//<cr>:let @/=''<CR>]], { remap = false, silent = true })

vim.keymap.set("c", "w!!", "w !sudo tee % > /dev/null")

vim.keymap.set("n", "gev", ":e $MYVIMRC<cr>", { remap = false })
vim.keymap.set("n", "gsv", ":so $MYVIMRC <bar> bufdo e<CR>", { remap = false })

if os.getenv "TMUX" == nil then
    for num = 1, 10 do
        vim.keymap.set("n", string.format("<A-%s>", num), string.format("<Esc>%sgt", num), { remap = false })
    end

    for num = 1, 10 do
        vim.keymap.set("i", string.format("<A-%s>", num), string.format("<Esc>%sgt", num), { remap = false })
    end

    for num = 1, 10 do
        vim.keymap.set("t", string.format("<A-%s>", num), string.format([[<C-\><C-n>%sgt]], num), { remap = false })
    end

    vim.keymap.set("n", "<A-h>", "<Esc>:tabprevious<CR>", { remap = false })
    vim.keymap.set("i", "<A-h>", "<Esc>:tabprevious<CR>", { remap = false })
    vim.keymap.set("t", "<A-h>", [[<C-\><C-n>:tabprevious<CR>]], { remap = false })

    vim.keymap.set("n", "<A-l>", "<Esc>:tabnext<CR>", { remap = false })
    vim.keymap.set("i", "<A-l>", "<Esc>:tabnext<CR>", { remap = false })
    vim.keymap.set("t", "<A-l>", [[<C-\><C-n>:tabnext<CR>]], { remap = false })
end
