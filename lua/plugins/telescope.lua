--[[
return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', '<leader>f', builtin.find_files, {})
            vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extension = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end
    }
}

]]

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- ADDED: native fzf for much faster fuzzy matching
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local builtin = require("telescope.builtin")

            require("telescope").setup({
                defaults = {
                    layout_strategy  = "horizontal",
                    sorting_strategy = "ascending",
                    layout_config    = { prompt_position = "top" },
                    file_ignore_patterns = { "%.o", "%.a", "build/", ".git/" },
                },
                -- BUG FIX: was `extension` (singular) — must be `extensions` (plural).
                -- With the typo, ui-select never loaded even though load_extension was called.
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                    },
                },
            })

            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("fzf")

            -- Keymaps
            vim.keymap.set("n", "<leader>ff", builtin.find_files,              { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep,               { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers,                 { desc = "Open buffers" })
            vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols,    { desc = "File symbols" })
            vim.keymap.set("n", "<leader>fr", builtin.lsp_references,          { desc = "LSP references" })
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics,             { desc = "Diagnostics" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags,               { desc = "Help tags" })
        end
    },

    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
}

