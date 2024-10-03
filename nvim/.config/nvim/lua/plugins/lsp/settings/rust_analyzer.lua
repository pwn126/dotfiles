return {
    settings = {
        -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
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
    },
}
