local general_augroup = vim.api.nvim_create_augroup("general_augroup", {
    clear = true
})

-- highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank { higroup = "Search", timeout = 200 }
    end,
    group = general_augroup
})
-- restore position
vim.api.nvim_create_autocmd("BufReadPost", {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
    group = general_augroup
})
-- equalize splits
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
    group = general_augroup
})
-- close fidget before exit
-- workaround for https://github.com/j-hui/fidget.nvim/issues/86
vim.api.nvim_create_autocmd("VimLeavePre", {
    command = [[silent! FidgetClose]],
    group = general_augroup
})
