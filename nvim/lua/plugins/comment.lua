-- comment.nvim - https://github.com/numToStr/Comment.nvim

return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local ft = require("Comment.ft")

        ft.set("systemd", "# %s")
        ft.set("conf", "# %s")
        ft.set("cfg", "# %s")
        ft.set("in", "# %s")
        ft.set("hog", "# %s")

        require("Comment").setup({
            pre_hook = function(ctx)
                local line_start = (ctx.srow or ctx.range.srow) - 1
                local line_end = ctx.erow or ctx.range.erow
                vim.api.nvim_buf_clear_namespace(0, -1, line_start, line_end)
            end,
        })
    end,
}
