-- outline - https://github.com/hedyhli/outline.nvim
return {
    "hedyhli/outline.nvim",
    keys = {
        {
            "<leader>o",
            "<cmd>Outline<cr>",
            desc = "Toggle outline",
        },
    },
    config = function()
        require("outline").setup {
            keymaps = {
                -- Jump to symbol under cursor but keep focus on outline window.
                peek_location = "p",
                toggle_preview = "P",
            }
        }
    end,
}
