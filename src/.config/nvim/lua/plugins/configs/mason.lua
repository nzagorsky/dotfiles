require("mason").setup()

require("mason-lspconfig").setup { ensure_installed = {
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
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers {

    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities
        }
    end,

    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["pyright"] = function()
    --     require("rust-tools").setup {}
    -- end
}
