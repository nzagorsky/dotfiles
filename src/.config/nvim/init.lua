local plugins = {
    {
        "stevearc/oil.nvim",
        dependencies = { { "echasnovski/mini.icons" } },
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },

    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup {
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = true, -- disables setting the background color.
                color_overrides = {
                    mocha = {
                        base = "#181818",
                        crust = "#111111",
                        mantle = "#161616",
                    },
                },
            }
            vim.cmd.colorscheme "catppuccin-mocha"
        end,
    },

    {
        "RRethy/vim-illuminate",
    },

    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            local nvim_tmux_nav = require "nvim-tmux-navigation"

            nvim_tmux_nav.setup {
                keybindings = {
                    left = "<C-h>",
                    down = "<C-j>",
                    up = "<C-k>",
                    right = "<C-l>",
                    last_active = "<C-\\>",
                    next = "<C-Space>",
                },
            }
        end,
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "echasnovski/mini.icons" },
        config = function()
            require("fzf-lua").setup {
                defaults = {
                    file_icons = "mini",
                },
                keymap = {
                    builtin = {
                        true,
                        ["jk"] = "hide",
                    },
                },
            }
        end,
        keys = {
            { "<leader>b", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>" },
            { "<leader>l", "<cmd>FzfLua lines<cr>" },
            { "<leader>f", "<cmd>FzfLua files<cr>" },
            { "<leader>c", "<cmd>FzfLua commands<cr>" },
            { "<leader>h", "<cmd>FzfLua help_tags<cr>" },
            { "<leader>t", "<cmd>FzfLua tags<cr>" },
            { "<leader>a", "<cmd>FzfLua grep<cr>" },
            { "<leader>A", "<cmd>FzfLua grep_cword<cr>" },
            { "<leader>:", "<cmd>FzfLua command_history<cr>" },
            { "<leader>dw", "<cmd>FzfLua lsp_document_diagnostics<cr>" },
            { "gr", "<cmd>FzfLua lsp_references<cr>" },
        },
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = function()
            require("mason").setup()

            local ensure_installed = {
                "lua-language-server",
                "pyright",
                "golangci-lint",
                "taplo",
                "ansible-language-server",
                "rust-analyzer",
                "bash-language-server",
                "cmake-language-server",
                "typescript-language-server",
                "stylua",
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
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                python = { "mypy", "ruff" },
                javascript = { "eslint" },
                go = { "golangcilint" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                group = lint_augroup,
                callback = function() require("lint").try_lint() end,
            })
        end,
    },

    {
        "stevearc/conform.nvim",
        keys = {
            { "<C-f>", function() require("conform").format() end },
        },
        config = function()
            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_fix", "ruff_format" },
                    swift = { { "swiftformat" } },
                    ["javascript"] = { "prettier" },
                    ["javascriptreact"] = { "prettier" },
                    ["typescript"] = { "prettier" },
                    ["go"] = { "goimports", "gofmt" },
                    ["typescriptreact"] = { "prettier" },
                    ["vue"] = { "prettier" },
                    ["css"] = { "prettier" },
                    ["toml"] = { "taplo" },
                    ["scss"] = { "prettier" },
                    ["less"] = { "prettier" },
                    ["html"] = { "prettier" },
                    ["json"] = { "prettier" },
                    ["jsonc"] = { "prettier" },
                    ["yaml"] = { "prettier" },
                    ["markdown"] = { "prettier" },
                    ["markdown.mdx"] = { "prettier" },
                    ["graphql"] = { "prettier" },
                    ["handlebars"] = { "prettier" },
                    ["sh"] = { "shfmt" },
                    ["bash"] = { "shfmt" },
                    ["zsh"] = { "shfmt" },
                },
            }
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = require("plugins.configs.lspconfig").config,
    },
    {
        "saghen/blink.cmp",
        dependencies = "rafamadriz/friendly-snippets",
        event = { "InsertEnter", "CmdlineEnter" },
        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "super-tab" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            signature = { window = { border = "rounded" } },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    border = "rounded",
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 50,
                    window = { border = "rounded" },
                },
            },
        },

        opts_extend = { "sources.default" },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                auto_install = true,
                indent = {
                    enable = false,
                },
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },
            }
        end,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            {
                "windwp/nvim-ts-autotag",
                config = function()
                    require("nvim-treesitter.configs").setup {
                        autotag = {
                            enable = true,
                        },
                    }
                end,
            },
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

    { "tpope/vim-repeat" },
    { "tpope/vim-rsi" },
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.comment").setup {}
            require("mini.surround").setup {}
            require("mini.pairs").setup {}
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup {
                open_mapping = [[<c-\>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
                direction = "float",
            }
        end,
    },

    {
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
    },

    {
        "lewis6991/gitsigns.nvim",
        config = require("plugins.configs.gitsigns").config,
    },

    -- { "isobit/vim-caddyfile" },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}

vim.loader.enable()

vim.g.mapleader = " "
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

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 4
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"

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
vim.o.titlestring = "nvim"
vim.o.titleold = "zsh"
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

vim.keymap.set("i", "jk", "<Esc>", { remap = false, nowait = true })
vim.keymap.set("c", "jk", "<Esc>", { remap = false, nowait = true })
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { remap = false, nowait = true })

vim.keymap.set("i", "ол", "<Esc>", { remap = false })
vim.keymap.set("c", "ол", "<Esc>", { remap = false })
vim.keymap.set("t", "ол", [[<C-\><C-n>]], { remap = false })

vim.keymap.set("n", "<leader><leader>", "V", { remap = false })
vim.keymap.set("n", "<leader>w", ":w<cr>", { remap = false })
vim.keymap.set("n", "<leader>q", ":q<cr>", { remap = false })
vim.keymap.set("n", "Y", "y$", { remap = false })

vim.keymap.set("n", "<a-x>", ":Commands<cr>", { remap = false })

-- vim.keymap.set("n", "<c-h>", "<C-w>h", { remap = true })
-- vim.keymap.set("n", "<c-j>", "<C-w>j", { remap = true })
-- vim.keymap.set("n", "<c-k>", "<C-w>k", { remap = true })
-- vim.keymap.set("n", "<c-l>", "<C-w>l", { remap = true })

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

vim.keymap.set("n", "<C-]>", [[:tag <c-r>=expand("<cword>")<cr><cr>]], { remap = false })

vim.keymap.set("n", "<a-j>", "<cmd>cnext<cr>")
vim.keymap.set("n", "<a-J>", "<cmd>cnfile<cr>")
vim.keymap.set("n", "<a-k>", "<cmd>cprev<cr>")
vim.keymap.set("n", "<a-K>", "<cmd>cNfile<cr>")

--- PLUGINS
require("lazy").setup(plugins)
