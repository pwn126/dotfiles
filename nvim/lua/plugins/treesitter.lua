-- treesitter - https://github.com/nvim-treesitter/nvim-treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- treesitter-context - https://github.com/nvim-treesitter/nvim-treesitter-context
        "nvim-treesitter/nvim-treesitter-context",
        -- treesitter-textobjects - https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            -- modules = {},
            ensure_installed = {
                "awk",
                "bash",
                "bitbake",
                "c",
                "cmake",
                "comment",
                "cpp",
                "devicetree",
                "diff",
                "dockerfile",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "haskell",
                "html",
                "ini",
                "json",
                "jq",
                "latex",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "ninja",
                "objdump",
                "passwd",
                "python",
                "query",
                "regex",
                "rst",
                "rust",
                "ssh_config",
                "toml",
                "vim",
                "vimdoc",
                "wit",
                "xml",
                "yaml",
            },
            ignore_install = {},
            auto_install = false,
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = "<c-s>",
                    node_decremental = "<c-s-space>",
                },
            },
            context_commentstring = {
                enable = true,
                config = {
                    -- Languages that have a single comment style
                    html = "<!-- %s -->",
                    json = "",
                    systemd = "# %s",
                    wit = "// %s",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",
                        ["ac"] = "@conditional.outer",
                        ["ic"] = "@conditional.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                    },
                },
                lsp_interop = {
                    enable = true,
                    border = "rounded",
                    floating_preview_opts = {},
                    peek_definition_code = {
                        ["<leader>df"] = "@function.outer",
                        ["<leader>dF"] = "@class.outer",
                    },
                },
            },
        })
    end,
}
