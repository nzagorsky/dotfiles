require("nvim-treesitter.configs").setup({
	-- one of "all", "maintained" (parsers with maintainers),
	-- or a list of languages
	ensure_installed = {
		"javascript",
		"cmake",
		"ruby",
		"elixir",
		"comment",
		"python",
		"lua",
		"vim",
		"html",
		"htmldjango",
		"dockerfile",
		"yaml",
		"go",
		"make",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
