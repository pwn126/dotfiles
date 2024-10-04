local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    return
end

local actions = require "telescope.actions"
local sorters = require "telescope.sorters"
local previewers = require "telescope.previewers"

local m = {}

m.find_files = function()
    require("telescope.builtin").find_files {
        prompt_title = "Find Files",
        follow = true,
        no_ignore = true,
    }
end

m.setup = function()
    telescope.setup {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--unrestricted",
            },
            prompt_prefix = "> ",
            selection_caret = "> ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "descending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    mirror = false,
                },
                vertical = {
                    mirror = false,
                },
            },
            file_sorter = sorters.get_fuzzy_file,
            file_ignore_patterns = {},
            generic_sorter = sorters.get_generic_fuzzy_sorter,
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            use_less = true,
            path_display = {},
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = previewers.vim_buffer_cat.new,
            grep_previewer = previewers.vim_buffer_vimgrep.new,
            qflist_previewer = previewers.vim_buffer_qflist.new,

            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = previewers.buffer_previewer_maker,
            mappings = {
                i = {
                    ["<c-c>"] = actions.close,
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous,
                    -- ["<c-t>"] = trouble.open_with_trouble,
                    ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    -- ["<c-x>"] = false,
                    ["<esc>"] = actions.close,
                    -- ["<c-i>"] = actions.select_horizontal,
                    ["<cr>"] = actions.select_default + actions.center,
                },
                n = {
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous,
                    ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                },
            }
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            }
        },
    }

    telescope.load_extension("fzf")

    local default_opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<leader>sf", require("user.telescope").find_files, default_opts)
    vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, default_opts)
    vim.keymap.set("n", "<leader>sG", require("telescope.builtin").grep_string, default_opts)
    vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, default_opts)
    vim.keymap.set("n", "<leader>sd", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, default_opts)
    vim.keymap.set("n", "<leader>sc", require("telescope.builtin").command_history, default_opts)
    vim.keymap.set("n", "<leader>sr", require("telescope.builtin").lsp_references, default_opts)
    vim.keymap.set("n", "<leader>sR", require("telescope.builtin").resume, default_opts)
    vim.keymap.set("n", "<leader>sm", require("telescope.builtin").marks, default_opts)
    vim.keymap.set("n", "<leader>sy", require("telescope.builtin").registers, default_opts)

    local notify_ok, _ = pcall(require, "notify")
    if notify_ok then
        telescope.load_extension("notify")
        vim.keymap.set("n", "<leader>fe", require("telescope").extensions.notify.notify, default_opts)
    end
end

return m
