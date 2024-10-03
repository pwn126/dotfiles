local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then
    return
end

local ft = require "Comment.ft"

ft.set("systemd", "# %s")
ft.set("conf", "# %s")
ft.set("cfg", "# %s")
ft.set("in", "# %s")
ft.set("rules", "# %s")

comment.setup {
    pre_hook = function(ctx)
        local line_start = (ctx.srow or ctx.range.srow) - 1
        local line_end = ctx.erow or ctx.range.erow
        vim.api.nvim_buf_clear_namespace(0, -1, line_start, line_end)
    end
}
