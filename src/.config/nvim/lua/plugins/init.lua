local present, packer = pcall(require, "plugins.packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(function()
  use 'wbthomason/packer.nvim'

  -- Python modules.
  use {'numirias/semshi', ft = {"python"}, run = vim.fn['remote#host#UpdateRemotePlugins']}
  use {'raimon49/requirements.txt.vim', ft = {"requirements"}}

  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Utility.
  if os.getenv("TMUX") == nil then
      use {'christoomey/vim-tmux-navigator'}
  end

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
  use {'tpope/vim-commentary'}
  use {'jiangmiao/auto-pairs'}
  use {'junegunn/goyo.vim'}

  -- Async command execution
  use {
      'tpope/vim-dispatch',
      opt = true,
      cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
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
  use {'sheerun/vim-polyglot', setup=[[vim.cmd("let g:polyglot_disabled = ['python']")]]}

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
