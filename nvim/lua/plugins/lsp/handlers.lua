local function lsp_keymaps(bufnr)
    local telescope_builtin_ok, telescope_builtin = pcall(require, "telescope.builtin")
    if not telescope_builtin_ok then
        vim.keymap.set("n", "gr", vim.lsp.buf.references, {
            buffer = bufnr,
            desc = "Go to references",
        })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
            buffer = bufnr,
            desc = "Go to definition",
        })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {
            buffer = bufnr,
            desc = "Go to implementation",
        })
    else
        vim.keymap.set("n", "gr", telescope_builtin.lsp_references, {
            buffer = bufnr,
            desc = "Search references",
        })
        vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, {
            buffer = bufnr,
            desc = "Go to definition",
        })
        vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, {
            buffer = bufnr,
            desc = "Go to implementation",
        })
    end

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
        buffer = bufnr,
        desc = "Go to declaration",
    })
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {
        buffer = bufnr,
        desc = "Go to definition",
    })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
        buffer = bufnr,
        desc = "Code actions",
    })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
        buffer = bufnr,
        desc = "Rename",
    })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
        buffer = bufnr,
        desc = "Hover information",
    })
    vim.keymap.set("n", "S", vim.lsp.buf.signature_help, {
        buffer = bufnr,
        desc = "Signature help",
    })
    vim.keymap.set("n", "<leader><leader>d", require("core.utils").toggleDiagnostics, {
        buffer = bufnr,
        desc = "Toggle diagnostics",
    })
    vim.keymap.set("n", "<leader><leader>D", function()
        require("core.utils").toggleDiagnostics(true)
    end, {
        buffer = bufnr,
        desc = "Toggle diagnostics",
    })
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, {
        buffer = bufnr,
        desc = "List workspace folders",
    })

    if vim.uv.os_uname().sysname == "Darwin" then
        -- <option>-d
        vim.keymap.set("n", "∂", function()
            vim.diagnostic.goto_next()
        end, { buffer = bufnr, desc = "Go to next diagnostic" })
        -- <option>-D
        vim.keymap.set("n", "™", function()
            vim.diagnostic.goto_prev()
        end, { buffer = bufnr, desc = "Go to previous diagnostic" })
    else
        vim.keymap.set("n", "<m-d>", function()
            vim.diagnostic.goto_next()
        end, { buffer = bufnr, desc = "Go to next diagnostic" })
        vim.keymap.set("n", "<m-D>", function()
            vim.diagnostic.goto_prev()
        end, { buffer = bufnr, desc = "Go to previous diagnostic" })
    end

    vim.keymap.set("n", "<leader>iH", require("core.utils").toggleInlayHints, {
        buffer = bufnr,
        desc = "Toggle inlay hints",
    })

    -- local conform_ok, _ = pcall(require, "conform")
    -- if not conform_ok then
    --     vim.keymap.set({ "n", "v" }, "<leader>f", function() vim.lsp.buf.format({ async = true }) end,
    --         {
    --             noremap = true, silent = false, buffer = bufnr, desc = "Format"
    --         })
    -- end
end

local m = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
    m.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
else
    m.capabilities = capabilities
end

m.setup = function()
    local icons = require("core.icons")

    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
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
        },
    }
    local handlers_config = {
        focusable = true,
        style = "minimal",
        border = "rounded",
    }

    vim.diagnostic.config(diagnostics_config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, handlers_config)
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, handlers_config)
end

m.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

    if vim.b[bufnr].diagnostics_disabled or vim.g.diagnostics_disabled then
        vim.diagnostic.disable(bufnr)
    end

    if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

return m
