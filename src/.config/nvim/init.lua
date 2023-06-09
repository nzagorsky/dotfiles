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
        lazy = false,
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
        config = require("plugins.configs.lspconfig").config,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require "null-ls"

            local sources = {
                -- null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.diagnostics.ansiblelint,
                null_ls.builtins.diagnostics.hadolint,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.cmake_format,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.sql_formatter,
            }

            null_ls.setup {
                sources = sources,
            }
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        config = require("plugins.configs.cmpconf").config,
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)

                    -- vscode format
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

                    -- snipmate format
                    require("luasnip.loaders.from_snipmate").load()
                    require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

                    -- lua format
                    require("luasnip.loaders.from_lua").load()
                    require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

                    vim.api.nvim_create_autocmd("InsertLeave", {
                        callback = function()
                            if
                                require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                                and not require("luasnip").session.jump_active
                            then
                                require("luasnip").unlink_current()
                            end
                        end,
                    })
                end,
            },

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
                    "comment",
                    "html",
                    "htmldjango",
                    "javascript",
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
        event = { "InsertEnter", "CmdlineEnter" },
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
