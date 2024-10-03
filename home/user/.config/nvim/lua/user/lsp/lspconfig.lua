local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

local handlers = require "user.lsp.handlers"

handlers.setup()

local servers = {
    "bashls",
    "clangd",
    "pyright",
    "rust_analyzer",
    "lua_ls",
    "taplo",
    "yamlls",
    "jsonls"
}

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    }

    if server == "bashls" then
        local bashls_opts = require "user.lsp.settings.bashls"
        opts = vim.tbl_deep_extend("force", bashls_opts, opts)
    end
    if server == "clangd" then
        local clangd_opts = require "user.lsp.settings.clangd"
        opts = vim.tbl_deep_extend("force", clangd_opts, opts)
    end
    if server == "pyright" then
        local pyright_opts = require "user.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end
    if server == "rust_analyzer" then
        local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
        if rust_tools_ok then
            local rust_tools_opts = require "user.lsp.settings.rust_tools"
            rust_tools.setup(rust_tools_opts)
            goto lspconfig_skip
        else
            local rust_analyzer_opts = require "user.lsp.settings.rust_analyzer"
            opts = vim.tbl_deep_extend("force", rust_analyzer_opts, opts)
        end
    end
    if server == "lua_ls" then
        local lua_ls_opts = require "user.lsp.settings.lua_ls"
        opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
    end

    lspconfig[server].setup(opts)

    ::lspconfig_skip::
end
