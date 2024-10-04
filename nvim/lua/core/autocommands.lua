local core_augroup = vim.api.nvim_create_augroup("core_augroup", {
    clear = true,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
    end,
    group = core_augroup,
})
-- restore position
vim.api.nvim_create_autocmd("BufReadPost", {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
    group = core_augroup,
})
-- equalize splits
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
    group = core_augroup,
})
