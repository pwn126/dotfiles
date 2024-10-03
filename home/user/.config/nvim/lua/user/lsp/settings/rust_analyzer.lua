return {
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
            hoverActions = {
                references = true,
            },
            procMacro = {
                enable = true,
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
                    enable = false,
                },
                debug = {
                    enable = false,
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
        },
    }
}
