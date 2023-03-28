local present, packer = pcall(require, "plugins.packerInit")

if not present then
    return false
end

local use = packer.use

return packer.startup(function()
    use 'wbthomason/packer.nvim'

    use 'lewis6991/impatient.nvim'

    -- HTML
    use { 'mattn/emmet-vim' }

    -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require("plugins.configs.nvim-tree") end,
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        }
    }

    -- Utility.
    use { 'christoomey/vim-tmux-navigator' }

    -- Style
    use {
        'drewtempelmeyer/palenight.vim',
        config = function() require('colors') end
    }

    -- Navigation
    use { 'junegunn/fzf' }
    use {
        'junegunn/fzf.vim',
        -- config=function() require("plugins.configs.fzf") end
        config = function() require("plugins.configs.fzf") end
    }

    -- SDE extensions.
    -- use {
    --     'neoclide/coc.nvim',
    --     config = function() require("plugins.configs.coc") end,
    --     branch = 'release'
    -- }
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate", -- :MasonUpdate updates registry contents
    }
    use {
        "williamboman/mason-lspconfig.nvim",
        config = function() require("plugins.configs.mason") end,
        requires = { { "hrsh7th/nvim-cmp" } }
    }
    use {
        'neovim/nvim-lspconfig',
        config = function() require("plugins.configs.lsp") end
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function() require("plugins.configs.null-ls") end

    }

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use {
        'hrsh7th/nvim-cmp',
        config = function() require("plugins.configs.cmp") end
    }

    -- Routine automation.
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-rsi' }
    use { 'tpope/vim-commentary' }
    use { 'jiangmiao/auto-pairs' }

    -- Async command execution
    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = { 'Dispatch', 'Make', 'Focus', 'Start' }
    }

    -- terminal
    use {
        'akinsho/toggleterm.nvim',
        branch = 'main',
        config = function() require("plugins.configs.term") end,
    }

    -- Tags
    use {
        'ludovicchabant/vim-gutentags'
    }

    -- Git integration.
    use {
        'tpope/vim-fugitive', config = function() require("plugins.configs.fugitive") end
    }

    -- Syntax highlightning for all languages.
    use { 'sheerun/vim-polyglot' }

    -- Vim
    use { 'Shougo/neco-vim', ft = { "vim" } }

    -- JSON
    use { 'elzr/vim-json', ft = { "json" } }

    -- REPL
    use { 'jpalardy/vim-slime' }

    -- DB
    use { 'tpope/vim-dadbod', opt = true }
    use { 'kristijanhusak/vim-dadbod-ui', requires = { "tpope/vim-dadbod" }, cmd = { "DBUI" } }
end)
