-- lsp-inlayhints - https://github.com/lvimuser/lsp-inlayhints.nvim

return {
    "lvimuser/lsp-inlayhints.nvim",
    enabled = false,
    branch = "main",
    event = { "BufWinEnter" },
    config = function()
        local lsp_inlayhints = require("lsp-inlayhints")

        vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
        vim.api.nvim_create_autocmd("LspAttach", {
            group = "LspAttach_inlayhints",
            callback = function(args)
                if not (args.data and args.data.client_id) then
                    return
                end

                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                require("lsp-inlayhints").on_attach(client, bufnr)
            end,
        })

        lsp_inlayhints.setup({
            inlay_hints = {
                parameter_hints = {
                    show = false,
                },
            },
        })

        vim.keymap.set("n", "<leader>iH", lsp_inlayhints.toggle, {
            desc = "Toggle inlay hints",
        })
    end,
}
