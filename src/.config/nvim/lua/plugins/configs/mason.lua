local util = require "lspconfig/util"
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local configs = require "lspconfig/configs"
local path = util.path

require("mason").setup()

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
    "yamlls",
  },
}

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "Pipfile"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
    return path.join(venv, "bin", "python")
  end

  -- Fallback to system Python.
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

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
  ["pyre"] = function()
    require("lspconfig").pyre.setup {
      root_dir = util.root_pattern("pyproject.toml", "requirements.txt"),
    }
  end,

  ["pyright"] = function()
    require("lspconfig").pyright.setup {
      before_init = function(_, config)
        config.settings.python.pythonPath = get_python_path(config.root_dir)
      end,
    }
  end,
}
