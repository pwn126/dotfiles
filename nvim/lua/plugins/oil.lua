return {
    "stevearc/oil.nvim",
    keys = {
        {
            "<leader>o",
            "<cmd>Oil<cr>",
            desc = "Toggle Oil file explorer",
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        columns = {
            "icon",
            "size",
            "mtime",
            "permissions",
        },
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<cr>"] = "actions.select",
            ["<c-v>"] = "actions.select_vsplit",
            ["<c-x>"] = "actions.select_split",
            ["<c-t>"] = "actions.select_tab",
            ["<c-p>"] = "actions.preview",
            ["<c-c>"] = "actions.close",
            ["<c-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },
        use_default_keymaps = true,
    },
}
