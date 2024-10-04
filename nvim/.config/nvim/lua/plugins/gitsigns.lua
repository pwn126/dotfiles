-- gitsigns - https://github.com/lewis6991/gitsigns.nvim

return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    return "]c"
                else
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end
            end, { expr = true })

            map("n", "[c", function()
                if vim.wo.diff then
                    return "[c"
                else
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end
            end, { expr = true })

            map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", {
                desc = "Stage hunk",
            })
            map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", {
                desc = "Reset hunk",
            })
            map("n", "<leader>hS", gs.stage_buffer, {
                desc = "Stage buffer",
            })
            map("n", "<leader>hu", gs.undo_stage_hunk, {
                desc = "Undo stage hunk",
            })
            map("n", "<leader>hR", gs.reset_buffer, {
                desc = "Reset buffer",
            })
            map("n", "<leader>hp", gs.preview_hunk, {
                desc = "Previous hunk",
            })
            map("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end, {
                desc = "Blame line",
            })
            map("n", "<leader>hB", gs.toggle_current_line_blame, {
                desc = "Toggle current line blame",
            })
            map("n", "<leader>hd", gs.diffthis, {})
            map("n", "<leader>hD", function()
                gs.diffthis("~")
            end, {
                desc = "Diff this",
            })
            map("n", "<leader>htd", gs.toggle_deleted, {
                desc = "Toggle delete",
            })
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {
                desc = "Select hunk",
            })
        end,
    },
}
