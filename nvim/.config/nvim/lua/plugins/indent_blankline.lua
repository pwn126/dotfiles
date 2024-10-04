-- indent-blankline - https://github.com/lukas-reineke/indent-blankline.nvim

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufWinEnter" },
    config = function()
        require("ibl").setup({
            indent = { char = "┊" },
            whitespace = { remove_blankline_trail = false },
            scope = {
                show_start = false,
                show_end = false,
                highlight = { "CursorLineNr" },
            },
        })

        vim.keymap.set("n", "<leader>tI", ":IBLToggle<cr>", {
            desc = "Toggle indentation marks",
        })
    end,
}
