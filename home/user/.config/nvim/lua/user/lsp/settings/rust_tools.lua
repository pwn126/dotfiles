local rust_tools_augroup = vim.api.nvim_create_augroup("default_augroup", { clear = true })

return {
    tools = {
        on_initialized = function()
            -- vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
                pattern = { "*.rs" },
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
                group = rust_tools_augroup,
            })
        end,
        autoSetHints = false, -- using lsp-inlayhints to show the hints
        hover_with_actions = false,
        inlay_hints = {
            parameter_hints_prefix = " ",
            other_hints_prefix = " ",
        },
    },
    server = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
        settings = {
            -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                completion = {
                    autoimport = {
                        enable = false,
                    }
                },
                assist = {
                    importGranularity = "module",
                    importPrefix = "self",
                },
                cargo = {
                    features = "all",
                },
                diagnostics = {
                    -- XXX
                    enableExperimental = true,
                },
                hover = {
                    actions = {
                        references = true,
                    }
                },
                checkOnSave = {
                    features = "all",
                    command = "clippy",
                },
                notifications = {
                    cargoTomlNotFound = false,
                },
                lens = {
                    run = {
                        enable = true,
                    },
                    debug = {
                        enable = true,
                    },
                    references = {
                        adt = {
                            enable = true,
                        },
                        enumVariant = {
                            enable = true,
                        },
                        method = {
                            enable = true,
                        },
                        trait = {
                            enable = true,
                        },
                    },
                },
                rustfmt = {
                    rangeFormatting = {
                        enable = true,
                    },
                },
                inlayHints = {
                    bindingModeHints = {
                        enable = true
                    },
                    closingBraceHints = {
                        minLines = 1,
                    }
                },
            },
        }
    }
}
