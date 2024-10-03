local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
    return
end

local colors = {}

local onenord_ok, onenord_colors = pcall(require, "onenord.colors")
if onenord_ok then
    colors = onenord_colors.load()
else
    colors = {
        error = "#bf616a",
        warn = "#ebcb8b",
        info = "#a3be8c",
        white = "#e5e9f0",
        purple = "#b988b0"
    }
end

local function whitespaces()
    if vim.api.nvim_buf_line_count(0) > 20000 then
        return ""
    end

    local pattern = [[\v((\s)|(\t))$]]

    local line = vim.fn.search(pattern, "nw", 0, 500)

    if line == 0 then
        return ""
    end

    return string.format("%s %d", "⚇", line)
end

local function indentation_file()
    if vim.api.nvim_buf_line_count(0) > 20000 then
        return ""
    end

    local tab_pattern = [[\v(^\t+)]]
    local space_pattern = [[\v(^ +\*@!)]]

    local line_tab = vim.fn.search(tab_pattern, "nw")
    local line_space = vim.fn.search(space_pattern, "nw")

    if line_tab > 0 and line_space > 0 then
        if line_tab > line_space then
            return string.format("%s %d:%d", "☵", line_space, line_tab)
        else
            return string.format("%s %d:%d", "☵", line_tab, line_space)
        end
    end

    return ""
end

local function indentation_line()
    if vim.api.nvim_buf_line_count(0) > 20000 then
        return ""
    end

    local tabSpace = [[(^\t+ +)]]
    local spaceTab = [[(^ +\t+)]]
    local pattern = string.format([[\v%s|%s]], tabSpace, spaceTab)

    local line = vim.fn.search(pattern, "nw", 0, 500)

    if line > 0 then
        return string.format("%s %d", "☱", line)
    end

    return ""
end

local mode = {
    function()
        return "▊"
    end,
    padding = { right = 1 },
}

local icons = require "user.icons"

lualine.setup {
    options = {
        -- theme = "onenord",
        theme = vim.g.my_colorscheme,
        section_separators = "",
        component_separators = "",
        globalstatus = true,
        icons_enabled = true,
    },
    sections = {
        lualine_a = {
            mode
        },
        lualine_b = {
            {
                "filename",
                file_status = true,
                path = 1,
                color = { fg = colors.fg_light },
                symbols = {
                    modified = " " .. icons.ui.Pencil, -- Text to show when the file is modified.
                    readonly = " " .. icons.ui.Lock, -- Text to show when the file is non-modifiable or readonly.
                    unnamed = "[No Name]", -- Text to show for unnamed buffers.
                    directory =  icons.documents.Folder, -- Text to show when the buffer is a directory
                }
            }
        },
        lualine_c = {
            {
                "branch",
                icon = "",
                color = { fg = colors.purple, gui = "bold" },
            }
        },
        lualine_x = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                color_error = colors.error,
                color_warn = colors.warn,
                color_info = colors.info,
                color_hint = colors.info
            },
            {
                whitespaces,
                color = { fg = colors.warn }
            },
            {
                indentation_file,
                color = { fg = colors.warn }
            },
            {
                indentation_line,
                color = { fg = colors.warn }
            },
            "filetype"
        },
        lualine_y = {
            {
                "progress",
                color = { fg = "#e5e9f0", bg = "#353B49" },
            }
        },
        lualine_z = {
            {
                "location",
                right_padding = 0,
                color = { fg = "#e5e9f0", bg = "#353B49" },
            }
        }
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {
            {
                "filename",
                file_status = true
            }
        },
        lualine_c = {
            {
                "branch",
                icon = "",
                color = { fg = colors.purple, gui = "bold" }
            }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
}
