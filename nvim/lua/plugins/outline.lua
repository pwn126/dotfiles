-- outline - https://github.com/hedyhli/outline.nvim
return {
    "hedyhli/outline.nvim",
    keys = {
        {
            "<leader><leader>o",
            "<cmd>Outline<cr>",
            desc = "Toggle outline",
        },
    },
    config = function()
        require("outline").setup {}
    end,
}
