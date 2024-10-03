local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
    return
end

local plugins = {
    -- impatient - https://github.com/lewis6991/impatient.nvim
    -- XXX remove if merged https://github.com/neovim/neovim/pull/15436
    {
        "lewis6991/impatient.nvim",
    },

    -- onenord - https://github.com/rmehri01/onenord.nvim
    {
        "rmehri01/onenord.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require "user.colorschemes.onenord"
        end
    },

    -- lualine - https://github.com/hoob3rt/lualine.nvim
    {
        "hoob3rt/lualine.nvim",
        config = function()
            require "user.lualine"
        end
    },

    -- lspconfig - https://github.com/neovim/nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "user.lsp.lspconfig"
        end
    },

    -- treesitter - https://github.com/nvim-treesitter/nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require "user.treesitter"
            require "user.treesitter-context"
        end
    },

    -- nvim-cmp - https://github.com/hrsh7th/nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require "user.cmp"
        end
    },

    -- telescope - https://github.com/nvim-telescope/telescope.nvim
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            require("user.telescope").setup()
        end
    },

    -- gitsigns - https://github.com/lewis6991/gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require "user.gitsigns"
        end
    },

    -- lsp_signature - https://github.com/ray-x/lsp_signature.nvim
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require "user.lsp.lsp-signature"
        end
    },

    -- comment.nvim - https://github.com/numToStr/Comment.nvim
    {
        "numToStr/Comment.nvim",
        config = function()
            require "user.comment"
        end
    },

    -- null-ls - https://github.com/jose-elias-alvarez/null-ls.nvim
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require "user.lsp.null-ls"
        end
    },

    -- luasnip - https://github.com/L3MON4D3/LuaSnip
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            -- friendly snippets - https://github.com/rafamadriz/friendly-snippets
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require "user.luasnip"
        end
    },

    -- lspkind - https://github.com/onsails/lspkind-nvim
    {
        "onsails/lspkind-nvim",
    },

    -- rust-tools - https://github.com/simrat39/rust-tools.nvim
    {
        "simrat39/rust-tools.nvim",
        -- NOTE: debugging
        -- dependencies = {
        --     "nvim-lua/plenary.nvim",
        --     "mfussenegger/nvim-dap",
        -- },
    },

    -- nvim-web-devicons -https://github.com/nvim-tree/nvim-web-devicons
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require "user.icons"
        end
    },

    -- illuminate - https://github.com/RRethy/vim-illuminate
    {
        "RRethy/vim-illuminate",
        config = function()
            require "user.illuminate"
        end
    },

    -- autopairs - https://github.com/windwp/nvim-autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require "user.autopairs"
        end
    },

    -- fidget - https://github.com/j-hui/fidget.nvim
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({})
        end
    },

    -- lsp-inlayhints - https://github.com/lvimuser/lsp-inlayhints.nvim
    {
        "lvimuser/lsp-inlayhints.nvim",
        branch = "main",
        config = function()
            require "user/lsp-inlayhints"
        end
    },

    -- indent-blankline - https://github.com/lukas-reineke/indent-blankline.nvim
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require "user.indent-blankline"
        end
    },
}

local opts = {
    ui = {
        border = "single",
    }
}

lazy.setup(plugins, opts)
