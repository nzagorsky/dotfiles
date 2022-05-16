local present, packer = pcall(require, "plugins.packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(function()

  use 'wbthomason/packer.nvim'

  use 'lewis6991/impatient.nvim'

  -- Python modules.
  use {'numirias/semshi', ft = {"python"}, run = vim.fn['remote#host#UpdateRemotePlugins']}
  use {'raimon49/requirements.txt.vim', ft = {"requirements"}}

  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
    'kyazdani42/nvim-tree.lua',
    config=function() require("plugins.configs.nvim-tree") end,
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
}

  -- Utility.
  use {'christoomey/vim-tmux-navigator'}

  -- Style
  use {
      'drewtempelmeyer/palenight.vim',
      config = function() require('colors') end
  }

  -- Files navigation.
  use {'junegunn/fzf'}
  use {
      'junegunn/fzf.vim',
      -- config=function() require("plugins.configs.fzf") end
      config=function() require("plugins.configs.fzf") end
  }

  -- Code check.
  use {
      'neoclide/coc.nvim',
      config=function() require("plugins.configs.coc") end,
      branch = 'release'
  }

  -- Routine automation.
  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-rsi'}
  use {'tpope/vim-commentary'}
  -- use {
  --     'numToStr/Comment.nvim',
  --     config = function()
  --         require('Comment').setup()
  --     end
  -- }

  use {'jiangmiao/auto-pairs'}
  use {'junegunn/goyo.vim'}

  -- Async command execution
  use {
      'tpope/vim-dispatch',
      opt = true,
      cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
  }

  -- terminal
  use {
      'akinsho/toggleterm.nvim',
      branch='main',
      config=function() require("plugins.configs.term") end,
}

  -- Tags
  use {
      'ludovicchabant/vim-gutentags'
  }

  -- Git integration.
  use {
      'tpope/vim-fugitive', config=function() require("plugins.configs.fugitive") end
  }

  -- Syntax highlightning for all languages.
  use {'sheerun/vim-polyglot'}

  -- Vim
  use {'Shougo/neco-vim', ft = {"vim"}}

  -- JSON
  use {'elzr/vim-json', ft = {"json"}}

  -- REPL
  use {'jpalardy/vim-slime'}

  -- DB
  use {'tpope/vim-dadbod', opt = true}
  use {'kristijanhusak/vim-dadbod-ui', requires = {"tpope/vim-dadbod"}, cmd = {"DBUI"}}

end)
