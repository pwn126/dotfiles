-- lualine - https://github.com/hoob3rt/lualine.nvim

return {
    "hoob3rt/lualine.nvim",
    config = function()
        local palette = require("catppuccin.palettes").get_palette()
        local colors = {
            error = palette.red,
            warn = palette.yellow,
            info = palette.green,
            white = palette.text,
            purple = palette.mauve,
            bg0 = palette.mantle,
            bg1 = palette.surface0,
            accent = palette.maroon,
        }

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

            local pattern

            if vim.o.expandtab then
                -- look for tabs
                pattern = [[\v(^\t+)]]
            else
                -- look for spaces
                pattern = [[\v(^ +\*@!)]]
            end

            local invalid_indentation = vim.fn.search(pattern, "nw")

            if invalid_indentation > 0 then
                return string.format("%s %d", "☵", invalid_indentation)
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

        local icons = require("core.icons")

        require("lualine").setup({
            options = {
                theme = "auto",
                section_separators = "",
                component_separators = "",
                globalstatus = true,
                icons_enabled = true,
            },
            sections = {
                lualine_a = {
                    {
                        function()
                            return "▊"
                        end,
                        padding = { right = 1 },
                    },
                },
                lualine_b = {
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                        color = { fg = colors.white },
                        symbols = {
                            modified = " " .. icons.ui.Pencil, -- Text to show when the file is modified.
                            readonly = " " .. icons.ui.Lock,   -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "[No Name]",             -- Text to show for unnamed buffers.
                            directory = icons.kind.Folder,     -- Text to show when the buffer is a directory
                        },
                    },
                },
                lualine_c = {
                    {
                        "branch",
                        icon = "",
                        color = { fg = colors.purple },
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                    },
                    {
                        whitespaces,
                        color = { fg = colors.warn },
                    },
                    {
                        indentation_file,
                        color = { fg = colors.warn },
                    },
                    {
                        indentation_line,
                        color = { fg = colors.warn },
                    },
                    "filetype",
                },
                lualine_y = {
                    {
                        "progress",
                        color = { fg = colors.white, bg = colors.bg0 },
                    },
                },
                lualine_z = {
                    {
                        "location",
                        right_padding = 0,
                        color = { fg = colors.white, bg = colors.bg0 },
                    },
                },
            },

            inactive_sections = {
                lualine_a = {},
                lualine_b = {
                    {
                        "filename",
                        file_status = true,
                    },
                },
                lualine_c = {
                    {
                        "branch",
                        icon = "",
                        color = { fg = colors.purple },
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}
