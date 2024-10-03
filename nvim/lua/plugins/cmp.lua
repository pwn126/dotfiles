-- nvim-cmp - https://github.com/hrsh7th/nvim-cmp

return {
    "hrsh7th/nvim-cmp",
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
        {
            "L3MON4D3/LuaSnip",
            dependencies = {
                -- friendly snippets - https://github.com/rafamadriz/friendly-snippets
                "rafamadriz/friendly-snippets",
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    config = function()
        local luasnip_ok, luasnip = pcall(require, "luasnip")
        if not luasnip_ok then
            return
        end
        local lspkind_ok, lspkind = pcall(require, "lspkind")
        if not lspkind_ok then
            return
        end

        local cmp = require("cmp")

        local WIDE_HEIGHT = 60

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noinsert,noselect",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            experimental = {
                ghost_text = true,
            },
            window = {
                documentation = {
                    border = vim.g.BORDER,
                    winhighlight =
                    "NormalFloat:Normal,FloatBorder:CompeFloatBorder,CursorLine:PmenuSel",
                    max_width = math.floor(
                        (WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))
                    ),
                    max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
                },
                completion = {
                    border = vim.g.BORDER,
                    winhighlight =
                    "NormalFloat:Normal,FloatBorder:CompeFloatBorder,CursorLine:PmenuSel",
                    max_width = math.floor(
                        (WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))
                    ),
                    max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
                },
            },
            mapping = {
                ["<c-k>"] = cmp.mapping.select_prev_item(),
                ["<c-j>"] = cmp.mapping.select_next_item(),
                ["<c-u>"] = cmp.mapping.scroll_docs(-4),
                ["<c-d>"] = cmp.mapping.scroll_docs(4),
                ["<c-space>"] = cmp.mapping.complete(),
                ["<c-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<cr>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                }),
                ["<tab>"] = cmp.mapping(function(fallback)
                    local has_words_before = function()
                        unpack = unpack or table.unpack
                        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                        return col ~= 0
                            and vim.api
                            .nvim_buf_get_lines(0, line - 1, line, true)[1]
                            :sub(col, col)
                            :match("%s")
                            == nil
                    end

                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<s-tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "codeium" },
                { name = "path" },
                { name = "buffer" },
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                    symbol_map = { Codeium = "" },

                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization.
                    -- See [#30](https://github.com/onsails/lspkind-nvim/pull/30)
                    before = function(entry, vim_item)
                        return vim_item
                    end,
                }),
            },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline("/", {
            completion = { completeopt = "menu,menuone,noinsert,noselect" },
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(":", {
            completion = { completeopt = "menu,menuone,noinsert,noselect" },
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "path" },
                { name = "cmdline" },
            },
        })

        vim.keymap.set({ "i", "s" }, "<C-L>", function()
            require("luasnip").jump(1)
        end, { desc = "Jump to next luasnip parameter" })
        vim.keymap.set({ "i", "s" }, "<C-J>", function()
            require("luasnip").jump(-1)
        end, { desc = "Jump to previous luasnip parameter" })
    end,
}
