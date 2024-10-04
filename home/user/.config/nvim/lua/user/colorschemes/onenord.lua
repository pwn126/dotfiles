local onenord_ok, onenord = pcall(require, "onenord")
if not onenord_ok then
    return
end

local colors = require("onenord.colors").load()

onenord.setup({
    borders = true,
    styles = {
        comments = "italic",
    },
    -- see https://github.com/rmehri01/onenord.nvim/blob/main/lua/onenord/colors/onenord.lua
    custom_colors = {},
    custom_highlights = {
        LspReferenceText = { style = "bold", sp = colors.yellow, bg = colors.highlight },
        LspReferenceRead = { link = "LspReferenceText" },
        LspReferenceWrite = { link = "LspReferenceText" },

        NormalFloat = { bg = colors.bg },
        FloatBorder = { bg = colors.bg },

        MatchParen = { fg = colors.yellow, bg = colors.none, style = "bold,underline" },

        Winbar = { fg = colors.fg, bg = colors.bg, style = "bold" },
        WinbarNC = { fg = colors.fg, bg = colors.bg, style = "bold" },
    }
})

-- highlight trailing whitespaces
vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = colors.dark_red })
vim.api.nvim_command("match ExtraWhitespace /\\s\\+$/")
