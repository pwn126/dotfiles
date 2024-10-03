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
            no_italic = true,
            no_underline = true,
            integrations = {
                cmp = true,
                dap = true,
                dap_ui = true,
                gitsigns = true,
                fidget = true,
                illuminate = {
                    enabled = true,
                    lsp = true,
                },
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                markdown = true,
                mason = true,
                neotree = true,
                notify = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
                native_lsp = {
                    enabled = true,
                    inlay_hints = {
                        background = true,
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
