local function lsp_keymaps(bufnr)
    local default_opts = { noremap = true, silent = false, buffer = bufnr }

    local telescope_builtin_ok, telescope_builtin = pcall(require, "telescope.builtin")
    if telescope_builtin_ok then
        vim.keymap.set("n", "<leader>gr", telescope_builtin.lsp_references, default_opts)
        vim.keymap.set("n", "<leader>gd", telescope_builtin.lsp_definitions, default_opts)
        vim.keymap.set("n", "<leader>gi", telescope_builtin.lsp_implementations, default_opts)
    else
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, default_opts)
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, default_opts)
        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, default_opts)
    end

    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, default_opts)
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, default_opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, default_opts)
    vim.keymap.set("n", "<leader><leader>f", function() vim.lsp.buf.format({ async = true }) end, default_opts)
    vim.keymap.set("n", "<leader><leader>F", function() vim.lsp.buf.range_formatting({ async = true }) end, default_opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, default_opts)
    vim.keymap.set("n", "S", vim.lsp.buf.signature_help, default_opts)

    vim.keymap.set("n", "<leader><leader>D", vim.diagnostic.disable, default_opts)
    vim.keymap.set("n", "<leader><leader>d", vim.diagnostic.enable, default_opts)

    vim.keymap.set("n", "<m-d>", function() vim.diagnostic.goto_next({ popup_opts = { border = "single" } }) end,
        default_opts)
    vim.keymap.set("n", "<m-D>", function() vim.diagnostic.goto_prev({ popup_opts = { border = "single" } }) end,
        default_opts)
end

local m = {}

m.capabilities = vim.lsp.protocol.make_client_capabilities()
m.capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_cmp")
if cmp_nvim_lsp_ok then
    m.capabilities = cmp_nvim_lsp.update_capabilities(m.capabilities)
end


m.setup = function()
    local icons = require "user.icons"

    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local diagnostics_config = {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = true,
            header = "",
            prefix = "",
            format = function(d)
                local t = vim.deepcopy(d)
                if d.code then
                    t.message = string.format("%s [%s]", t.message, t.code):gsub("1. ", "")
                end
                return t.message
            end,
        }

    }
    local handlers_config = {
        focusable = true,
        style = "minimal",
        border = "rounded",
    }

    vim.diagnostic.config(diagnostics_config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, handlers_config)
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
        handlers_config)
end

m.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

    if client.server_capabilities.documentSymbolProvider then
        local navic_ok, navic = pcall(require, "nvim-navic")
        if navic_ok then
            navic.attach(client, bufnr)
        end
    end
end

return m
