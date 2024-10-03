local indent_blankline_ok, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_ok then
    return
end

indent_blankline.setup {
    indentLine_enabled = 1,
    show_current_context = false,
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    use_treesitter_scope = 1,
    buftype_exclude = {
        "terminal",
        "nofile",
    },
    filetype_exclude = {
        "help",
        -- "packer",
        "neogitstatus",
        "Trouble",
        "text"
    }
}

local default_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader><leader>I", ":IndentBlanklineToggle!<cr>", default_opts)
