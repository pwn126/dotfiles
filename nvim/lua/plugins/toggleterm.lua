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
            open_mapping = [[<c-t>]],
            start_in_insert = true,
            -- shading_factor = -10, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            -- float_opts = {
            --     border = "rounded",
            --     winblend = 0,
            --     highlights = {
            --         border = "Normal",
            --         background = "Normal",
            --     },
            -- },
        }
    end
}
