-- rustaceanvim - https://github.com/mrcjkb/rustaceanvim

return {
    "mrcjkb/rustaceanvim",
    enabled = true,
    version = "^4",
    ft = { "rust" },
    config = function()
        vim.g.rustaceanvim = {
            tools = {
                float_win_config = {
                    border = vim.g.BORDER,
                }
            },
            -- LSP configuration
            server = {
                on_attach = require("plugins.lsp.handlers").on_attach,
                -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
                default_settings = {
                    cargo = {
                        features = "all",
                    },
                    completion = {
                        autoimport = {
                            enable = false,
                        },
                        fullFunctionSignatures = {
                            enable = true,
                        },
                    },
                    diagnostics = {
                        experimental = {
                            enable = true,
                        },
                    },
                    hover = {
                        actions = {
                            references = {
                                enable = true,
                            },
                        },
                    },
                    check = {
                        command = "clippy",
                    },
                    lens = {
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
                },
            },
        }
    end,
}
