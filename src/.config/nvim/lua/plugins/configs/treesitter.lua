require('nvim-treesitter.configs').setup {
    -- one of "all", "maintained" (parsers with maintainers),
    -- or a list of languages
    ensure_installed = { "javascript", "ruby", "elixir", "comment", "python" },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,

    } }
