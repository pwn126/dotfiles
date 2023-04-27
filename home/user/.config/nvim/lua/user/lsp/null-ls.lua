local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end

-- XXX fix for null-ls breaking text formatting with gq
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131#issuecomment-1457584752
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.name == "null-ls" then
            if not require("null-ls.generators").can_run(vim.bo[buffer].filetype, require("null-ls.methods").lsp.FORMATTING) then
                vim.bo[buffer].formatexpr = nil
            end
        end
    end
})

null_ls.setup {
    update_in_insert = false,
    on_attach = require("user.lsp.handlers").on_attach,
    sources = {
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.trail_space,

        null_ls.builtins.formatting.trim_whitespace,
        null_ls.builtins.formatting.black.with({
            extra_args = { "-l", "100" },
        }),

        null_ls.builtins.code_actions.shellcheck.with({
            filetypes = { "sh" },
        }),
    },
}

local default_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader><leader>N", function() require("null-ls").toggle({}) end, default_opts)
