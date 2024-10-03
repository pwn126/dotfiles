-- mason - https://github.com/williamboman/mason.nvim

return {
    "williamboman/mason.nvim",
    branch = "main",
    dependencies = {
        -- mason-lspconfig - https://github.com/williamboman/mason-lspconfig.nvim
        "williamboman/mason-lspconfig.nvim",
        -- mason-tool-installer - https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
                width = 0.8,
                height = 0.8,
            },
        })

        local mason_lspconfig = require("mason-lspconfig")

        -- ensure LSP servers to be installed
        mason_lspconfig.setup({
            ensure_installed = {
                "bashls",
                "clangd",
                "cmake",
                "dockerls",
                "jsonls",
                "lua_ls",
                "marksman",
                "pyright",
                -- "rust_analyzer@2024-04-29",
                "rust_analyzer",
                "taplo",
                "yamlls",
            },
        })

        local mason_tool_installer = require("mason-tool-installer")

        -- ensure formatters and linters to be installed
        mason_tool_installer.setup({
            ensure_installed = {
                "beautysh",
                "black",
                "clang-format",
                "codelldb",
                "gitlint",
                "isort",
                "markdownlint",
                "prettier",
                "shellcheck",
                "shellharden",
            },
            auto_update = true,
        })
    end,
}
