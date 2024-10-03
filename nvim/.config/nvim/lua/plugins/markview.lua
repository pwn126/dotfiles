-- markview - https://github.com/OXY2DEV/markview.nvim

return {
    "OXY2DEV/markview.nvim",
    ft = "markdown",

    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },

    config = function()
        local markview = require("markview")

        require("markview").setup({
            code_blocks = {
                enable = true,
                style = "language",
                hl = "Layer2",
                min_width = 60,
                pad_amount = 3,
                language_names = {
                    { "py",  "python" },
                    { "cpp", "C++" }
                },
                language_direction = "right",
                sign = "",
            },
            horizontal_rules = {
                enable = true,

                position = "overlay",
                parts = {
                    {
                        type = "repeating",
                        repeat_amount = function() --[[@as function]]
                            local textoff = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
                                .textoff;

                            return math.floor((vim.o.colorcolumn - textoff) / 2);
                        end,

                        text = "─",
                        hl = {
                            "MarkviewGradient1", "MarkviewGradient2", "MarkviewGradient3",
                            "MarkviewGradient4", "MarkviewGradient5", "MarkviewGradient6",
                            "MarkviewGradient7", "MarkviewGradient8", "MarkviewGradient9",
                            "MarkviewGradient10"
                        }
                    },
                    {
                        type = "repeating",
                        repeat_amount = function() --[[@as function]]
                            local textoff = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
                                .textoff;

                            -- return math.ceil((vim.o.columns - textoff - 3) / 2);
                            return math.ceil((vim.o.colorcolumn - textoff) / 2);
                        end,

                        direction = "right",
                        text = "─",
                        hl = {
                            "MarkviewGradient1", "MarkviewGradient2", "MarkviewGradient3",
                            "MarkviewGradient4", "MarkviewGradient5", "MarkviewGradient6",
                            "MarkviewGradient7", "MarkviewGradient8", "MarkviewGradient9",
                            "MarkviewGradient10"
                        }
                    }
                }
            },

            headings = {
                enable = true,
                shift_width = 0,

                heading_1 = {
                    style = "label",
                    icon = require("core.icons").ui.BookMark .. " ",
                    hl = "MarkviewCol1",
                    sign = "",
                },
                heading_2 = {
                    style = "label",
                    icon = require("core.icons").ui.BookMark .. " ",
                    hl = "MarkviewCol2",
                    sign = "",
                },
                heading_3 = {
                    style = "label",
                    icon = require("core.icons").ui.BookMark .. " ",
                    hl = "MarkviewCol3",
                    sign = "",
                },
                heading_4 = {
                    style = "label",
                    icon = require("core.icons").ui.BookMark .. " ",
                    hl = "MarkviewCol4",
                    sign = "",
                },
                heading_5 = {
                    style = "label",
                    icon = require("core.icons").ui.BookMark .. " ",
                    hl = "MarkviewCol5",
                    sign = "",
                },
                heading_6 = {
                    style = "label",
                    icon = require("core.icons").ui.BookMark .. " ",
                    hl = "MarkviewCol6",
                    sign = "",
                },
            },
            highlight_groups = {
                {
                    group_name = "Col1",
                    value = function()
                        local bg = markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg");
                        local fg = markview.colors.get_hl_value(0, "markdownH1", "fg") or "#f38ba8";

                        return {
                            bg = markview.colors.mix(bg, fg, 0.7, 0.25),
                            fg = fg
                        }
                    end
                },
                {
                    group_name = "Col1Fg",
                    value = function()
                        local fg = markview.colors.get_hl_value(0, "markdownH1", "fg") or "#f38ba8";

                        return {
                            fg = fg
                        }
                    end
                },

                {
                    group_name = "Col2",
                    value = function()
                        local bg = markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg");
                        local fg = markview.colors.get_hl_value(0, "markdownH2", "fg") or "#fab387";

                        return {
                            bg = markview.colors.mix(bg, fg, 0.7, 0.25),
                            fg = fg
                        }
                    end
                },
                {
                    group_name = "Col2Fg",
                    value = function()
                        local fg = markview.colors.get_hl_value(0, "markdownH2", "fg") or "#fab387";

                        return {
                            fg = fg
                        }
                    end
                },

                {
                    group_name = "Col3",
                    value = function()
                        local bg = markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg");
                        local fg = markview.colors.get_hl_value(0, "markdownH3", "fg") or "#f9e2af";

                        return {
                            bg = markview.colors.mix(bg, fg, 0.7, 0.25),
                            fg = fg
                        }
                    end
                },
                {
                    group_name = "Col3Fg",
                    value = function()
                        local fg = markview.colors.get_hl_value(0, "markdownH3", "fg") or "#f9e2af";

                        return {
                            fg = fg
                        }
                    end
                },

                {
                    group_name = "Col4",
                    value = function()
                        local bg = markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg");
                        local fg = markview.colors.get_hl_value(0, "markdownH4", "fg") or "#a6e3a1";

                        return {
                            bg = markview.colors.mix(bg, fg, 0.7, 0.25),
                            fg = fg
                        }
                    end
                },
                {
                    group_name = "Col4Fg",
                    value = function()
                        local fg = markview.colors.get_hl_value(0, "markdownH4", "fg") or "#a6e3a1";

                        return {
                            fg = fg
                        }
                    end
                },

                {
                    group_name = "Col5",
                    value = function()
                        local bg = markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg");
                        local fg = markview.colors.get_hl_value(0, "markdownH5", "fg") or "#74c7ec";

                        return {
                            bg = markview.colors.mix(bg, fg, 0.7, 0.25),
                            fg = fg
                        }
                    end
                },
                {
                    group_name = "Col5Fg",
                    value = function()
                        local fg = markview.colors.get_hl_value(0, "markdownH5", "fg") or "#74c7ec";

                        return {
                            fg = fg
                        }
                    end
                },

                {
                    group_name = "Col6",
                    value = function()
                        local bg = markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg");
                        local fg = markview.colors.get_hl_value(0, "markdownH6", "fg") or "#b4befe";

                        return {
                            bg = markview.colors.mix(bg, fg, 0.7, 0.25),
                            fg = fg
                        }
                    end
                },
                {
                    group_name = "Col6Fg",
                    value = function()
                        local fg = markview.colors.get_hl_value(0, "markdownH6", "fg") or "#b4befe";

                        return {
                            fg = fg
                        }
                    end
                },

                {
                    group_name = "Col7",
                    value = function()
                        local bg = markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg");
                        local fg = markview.colors.get_hl_value(0, "Comment", "fg");

                        return {
                            bg = markview.colors.mix(bg, fg, 0.7, 0.25),
                            fg = fg
                        }
                    end
                },
                {
                    group_name = "Col7Fg",
                    value = function()
                        local fg = markview.colors.get_hl_value(0, "Comment", "fg");

                        return {
                            fg = fg
                        }
                    end
                },

                {
                    group_name = "Layer",
                    value = function()
                        local bg = markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg");
                        local fg = markview.colors.get_hl_value(0, "Comment", "fg");

                        local txt = markview.colors.get_hl_value(0, "FloatTitle", "fg")

                        return {
                            bg = markview.colors.mix(bg, fg, 1, 0.20),
                            fg = txt
                        }
                    end
                },
                {
                    group_name = "Layer2",
                    value = function()
                        local bg = markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg");
                        local fg = markview.colors.get_hl_value(0, "Comment", "fg");

                        return {
                            bg = markview.colors.mix(bg, fg, 0.85, 0.13),
                        }
                    end
                },
                {
                    output = function()
                        return markview.colors.create_gradient("Gradient",
                            markview.colors.get_hl_value(0, "Normal", "bg") or
                            markview.colors.get_hl_value(0, "Cursor", "fg"),
                            markview.colors.get_hl_value(0, "Title", "fg"), 10, "fg");
                    end
                }
            },
        });

        vim.keymap.set("n", "<leader>tm", ":Markview toggle<cr>", {
            desc = "Toggle markdown concealing",
        })
    end
}
