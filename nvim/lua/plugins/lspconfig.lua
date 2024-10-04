-- lspconfig - https://github.com/neovim/nvim-lspconfig

return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local handlers = require("plugins.lsp.handlers")

        handlers.setup()

        local servers = {
            "bashls",
            "clangd",
            "cmake",
            "pyright",
            -- "rust_analyzer",
            "lua_ls",
            "taplo",
            "yamlls",
            "jsonls",
            "marksman",
            "dockerls",
        }

        local opts = {}

        for _, server in pairs(servers) do
            opts = {
                on_attach = handlers.on_attach,
                capabilities = handlers.capabilities,
            }

            -- extra settings for some lsp servers
            if server == "bashls" then
                local bashls_opts = require("plugins.lsp.settings.bashls")
                opts = vim.tbl_deep_extend("force", bashls_opts, opts)
            end
            if server == "clangd" then
                local clangd_opts = require("plugins.lsp.settings.clangd")
                opts = vim.tbl_deep_extend("force", clangd_opts, opts)
            end
            if server == "pyright" then
                local pyright_opts = require("plugins.lsp.settings.pyright")
                opts = vim.tbl_deep_extend("force", pyright_opts, opts)
            end
            if server == "rust_analyzer" then
                local rust_analyzer_opts = require("plugins.lsp.settings.rust_analyzer")
                opts = vim.tbl_deep_extend("force", rust_analyzer_opts, opts)
            end
            if server == "lua_ls" then
                local lua_ls_opts = require("plugins.lsp.settings.lua_ls")
                opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
            end
            if server == "jsonls" then
                local jsonls_opts = require("plugins.lsp.settings.jsonls")
                opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
            end

            lspconfig[server].setup(opts)
        end
    end,
}
