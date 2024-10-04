-- fidget - https://github.com/j-hui/fidget.nvim

return {
    "j-hui/fidget.nvim",
    branch = "main",
    event = { "BufReadPre" },
    config = function()
        require("fidget").setup({
            progress = {
                suppress_on_insert = true,
            },
        })

        local fidget_augroup = vim.api.nvim_create_augroup("fidget_augroup", {
            clear = true,
        })

        -- close fidget before exit
        -- workaround for https://github.com/j-hui/fidget.nvim/issues/86
        vim.api.nvim_create_autocmd("VimLeavePre", {
            command = [[silent! FidgetClose]],
            group = fidget_augroup,
        })
    end,
}
