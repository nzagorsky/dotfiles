return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
        require("mason").setup()

        local ensure_installed = {
            "ansible-language-server",
            "bash-language-server",
            "cmake-language-server",
            "docker-compose-language-service",
            "dockerfile-language-server",
            "golangci-lint",
            "gopls",
            "html-lsp",
            "json-lsp",
            "lua-language-server",
            "basedpyright",
            "marksman",
            "rust-analyzer",
            "shfmt",
            "sqlls",
            "stylua",
            "taplo",
            "terraform-ls",
            "typescript-language-server",
            "yaml-language-server",
        }

        vim.api.nvim_create_user_command(
            "MasonInstallAll",
            function() vim.cmd("MasonInstall " .. table.concat(ensure_installed, " ")) end,
            {}
        )
    end,
}
