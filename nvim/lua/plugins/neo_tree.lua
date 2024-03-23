-- neo-tree - https://github.com/nvim-neo-tree/neo-tree.nvim

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
        {
            "<leader><leader>t",
            "<cmd>Neotree reveal toggle<cr>",
            desc = "Toggle tree view for files",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
        close_if_last_window = true,
        window = {
            position = "left",
            mappings = {
                ["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                ["P"] = "focus_preview",
                ["<c-x>"] = "open_split",
                ["<c-v>"] = "open_vsplit",
            },
        },
    },
}
