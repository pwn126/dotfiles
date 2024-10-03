-- toggleterm - https://github.com/akinsho/toggleterm.nvim

return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup {
            -- size = 20
            size = function(term)
                if term.direction == "horizontal" then
                    return vim.o.lines * 0.4
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            -- open_mapping = [[<c-t>]],
            open_mapping = [[t]],
            insert_mappings = false,
            start_in_insert = true,
        }
        vim.keymap.set("t", "jj", "<C-\\><C-n>", {
            desc = "Exit terminal mode"
        })
        vim.keymap.set("t", "kk", "<C-\\><C-n>", {
            desc = "Exit terminal mode"
        })
    end
}
