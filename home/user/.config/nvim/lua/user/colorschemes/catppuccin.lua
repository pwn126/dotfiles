local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_ok then
    return
end

catppuccin.setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    background = {
        -- :h background
        light = "latte",
        dark = "frappe",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false,   -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        illuminate = true,
        markdown = true,
        notify = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        fidget = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = {},
                hints = {},
                warnings = {},
                information = {},
            },
        },
    },
})

vim.cmd.colorscheme("catppuccin")
