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

--- PLUGINS
require("lazy").setup {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            }
            vim.cmd "colorscheme catppuccin-mocha"
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            { "<c-n>", ":NvimTreeToggle<CR>" },
            { "<c-b>", ":NvimTreeOpen<CR>:NvimTreeCollapseKeepBuffers<CR>" },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        config = function()
            require("nvim-tree").setup {
                sort_by = "case_sensitive",
                update_focused_file = {
                    enable = true,
                },
            }
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = require("plugins.configs.telescope").keys,
        config = require("plugins.configs.telescope").config,
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
                "rust-analyzer",
                "bash-language-server",
                "cmake-language-server",
                "typescript-language-server",
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
                markdown = { "vale" },
                python = { "mypy" },
                javascript = { "eslint" },
            }
        end,
    },
    {
        "stevearc/conform.nvim",
        keys = {
            { "<F3>", function() require("conform").format() end },
        },
        config = function()
            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    swift = { { "swiftformat" } },
                    ["javascript"] = { "prettier" },
                    ["javascriptreact"] = { "prettier" },
                    ["typescript"] = { "prettier" },
                    ["typescriptreact"] = { "prettier" },
                    ["vue"] = { "prettier" },
                    ["css"] = { "prettier" },
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
                },
            }
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = require("plugins.configs.lspconfig").config,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        config = require("plugins.configs.cmpconf").config,
        dependencies = {
            { "L3MON4D3/LuaSnip" },

            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },

                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
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
                    "swift",
                    "go",
                    "comment",
                    "html",
                    "htmldjango",
                    "javascript",
                    "regex",
                    "markdown",
                    "markdown_inline",
                    "sql",
                    "lua",
                    "python",
                    "rust",
                    "toml",
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
                    -- theme = "tokyonight",
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
                open_mapping = [[<a-j>]],
                hide_numbers = true, -- hide the number column in toggleterm buffers
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
                terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
                -- shade_terminals = true,
                persist_size = true,
                close_on_exit = true, -- close the terminal window when the process exits
                shell = vim.o.shell, -- change the default shell
                direction = "horizontal",
                -- float_opts = { -- This field is only relevant if direction is set to 'float'
                --     border = "single",
                --     width = function(term) return math.floor(vim.o.columns * 0.90) end,
                --     height = function(term) return math.floor(vim.o.lines * 0.80) end,
                -- },
            }
        end,
    },

    {
        "ludovicchabant/vim-gutentags",
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
    {
        "folke/neodev.nvim",
        ft = "lua",
        config = function() require("neodev").setup { library = { plugins = { "nvim-dap-ui" }, types = true } } end,
    },
}

vim.keymap.set("i", "jk", "<Esc>", { remap = false, nowait = true })
vim.keymap.set("c", "jk", "<Esc>", { remap = false, nowait = true })
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { remap = false, nowait = true })

vim.keymap.set("i", "ол", "<Esc>", { remap = false })
vim.keymap.set("c", "ол", "<Esc>", { remap = false })
vim.keymap.set("t", "ол", [[<C-\><C-n>]], { remap = false })

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

vim.keymap.set("n", "<C-]>", [[:tag <c-r>=expand("<cword>")<cr><cr>]], { remap = false })

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
