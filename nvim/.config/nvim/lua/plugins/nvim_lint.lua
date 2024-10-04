-- nvim-lint - https://github.com/mfussenegger/nvim-lint

return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local nvim_lint = require("lint")

        nvim_lint.linters_by_ft = {
            markdown = { "markdownlint" },
            gitcommit = { "gitlint" },
        }

        local markdownlint = nvim_lint.linters.markdownlint
        markdownlint.args = {
            "--config=~/.config/nvim/.markdownlint.json",
            "-",
        }
        local gitlint = nvim_lint.linters.gitlint
        gitlint.args = {
            "--contrib=contrib-title-conventional-commits",
            "--staged",
            "--msg-filename",
            function()
                return vim.api.nvim_buf_get_name(0)
            end,
        }

        local nvim_lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = nvim_lint_augroup,
            callback = function()
                nvim_lint.try_lint()
            end,
        })
    end,
}
