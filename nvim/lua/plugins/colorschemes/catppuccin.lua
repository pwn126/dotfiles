-- catppucin - https://github.com/catppuccin/nvim

return {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            background = {
                -- :h background
                light = "latte",
                dark = "macchiato",
            },
            styles = {
                conditionals = {},
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                fidget = true,
                illuminate = true,
                markdown = true,
                mason = true,
                notify = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = {},
                        hints = {},
                        warnings = {},
                        information = {},
                    },
                    inlay_hints = {
                        background = false,
                    },
                },
            },
            custom_highlights = function(color)
                return {
                    WinSeparator = { fg = color.blue },
                }
            end,
        })

        local colors = require("catppuccin.palettes").get_palette()

        vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = colors.red })
        vim.api.nvim_command("match ExtraWhitespace /\\s\\+$/")

        vim.cmd.colorscheme("catppuccin")
    end,
}
