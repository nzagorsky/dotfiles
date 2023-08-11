local M = {
    keys = {
        {
            "<leader>?",
            function() require("telescope.builtin").oldfiles() end,
        },

        {
            "<leader>b",
            function() require("telescope.builtin").buffers { sort_mru = true } end,
        },

        {
            "<leader>/",
            function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        },

        {
            "<leader>l",
            function()
                require("telescope.builtin").live_grep {
                    prompt_title = "find string in open buffers...",
                    disable_coordinates = true,
                    grep_open_files = true,
                }
            end,
        },

        {
            "<leader>f",
            function() require("telescope.builtin").find_files() end,
        },

        {
            "<leader>c",
            function() require("telescope.builtin").commands() end,
        },

        {
            "<leader>h",
            function() require("telescope.builtin").help_tags() end,
        },

        {
            "<leader>t",
            function()
                require("telescope.builtin").tags {
                    fname_width = 50,
                    show_line = false,
                    ctags_file = vim.fn.getcwd() .. "/tags",
                }
            end,
        },

        {
            "<leader>a",
            function()
                require("telescope.builtin").grep_string {
                    search = vim.fn.input { prompt = "Search string: ", default = "" },
                    disable_coordinates = true,
                    hidden = true,
                }
            end,
        },

        {
            "<leader>A",
            function()
                require("telescope.builtin").grep_string {
                    disable_coordinates = true,
                }
            end,
        },

        {
            "<leader>d",
            function()
                require("telescope.builtin").diagnostics {
                    bufnr = 0,
                }
            end,
        },

        {
            "<leader>dw",
            function() require("telescope.builtin").diagnostics() end,
        },

        {
            "gr",
            function()
                require("telescope.builtin").lsp_references {
                    fname_width = 50,
                    include_declaration = false,
                    jump_type = "never",
                }
            end,
        },
    },
    config = function()
        pcall(require("telescope").load_extension, "fzf")

        local actions = require "telescope.actions"
        local telescope_mappings = {
            ["jk"] = actions.close,
            ["<leader>q"] = actions.close,
            ["<Esc>"] = actions.close,
            ["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
        }

        require("telescope").setup {
            defaults = {
                file_ignore_patterns = { "node_modules", ".git/" },
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--follow",
                    "--hidden",
                },
                mappings = {
                    i = telescope_mappings,
                    n = telescope_mappings,
                },
                sorting_strategy = "descending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = { prompt_position = "bottom", preview_width = 0.35, results_width = 0.8 },
                    vertical = { mirror = false },
                    width = 1000,
                    height = 1000,
                    preview_cutoff = 120,
                },
            },
            pickers = {
                find_files = { find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden" } },
                buffers = { mappings = { i = { ["<c-d>"] = actions.delete_buffer + actions.move_to_top } } },
            },
        }
    end,
}

return M
