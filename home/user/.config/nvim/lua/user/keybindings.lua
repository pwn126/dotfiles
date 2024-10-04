local default_opts = { noremap = true, silent = true }

-- leader key is space
vim.g.mapleader = " "

-- map ctrl-c to ESC
vim.keymap.set({ "i", "c" }, "<c-c>", "<ESC>", default_opts)
vim.keymap.set({ "i", "c" }, "jj", "<ESC>", default_opts)
vim.keymap.set({ "i", "c" }, "kk", "<ESC>", default_opts)

-- toggle search highlighting
vim.keymap.set("n", "<leader>H", ":set hlsearch!<cr>", default_opts)

-- wrapped lines goes down/up to next row, rather than next line in file
vim.keymap.set("", "j", "gj", default_opts)
vim.keymap.set("", "k", "gk", default_opts)

-- find merge conflict markers
-- vim.keymap.set("n", "<leader>fc", "\\v^[<|=|>]{7}( .*|$)<cr>", default_opts)
vim.keymap.set("n", "<leader>gc", "/\\v^[<\\|=\\|>]{7}( .*|$)<cr>", default_opts)

-- toggle list characters
vim.keymap.set("n", "<leader>L", ":set list!<cr>", default_opts)

-- retab
vim.keymap.set("n", "<leader>rt", ":%retab!<cr>", default_opts)

-- close buffer without closing the split
vim.keymap.set("n", "<leader>bd", ":b#<bar>bd#<cr>", default_opts)

-- yank from pos to end of line
vim.keymap.set("n", "Y", "y$", default_opts)

-- keep cursor line in one place when skipping around or joining lines
vim.keymap.set("n", "n", "nzzzv", default_opts)
vim.keymap.set("n", "N", "Nzzzv", default_opts)
vim.keymap.set("n", "J", "mzJ'z", default_opts)

-- place more undo break points
vim.keymap.set("i", ",", ",<c-g>u", default_opts)
vim.keymap.set("i", ".", ".<c-g>u", default_opts)
vim.keymap.set("i", "!", "!<c-g>u", default_opts)
vim.keymap.set("i", "?", "?<c-g>u", default_opts)

-- more detailed jump list
vim.keymap.set("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . "j"]], { expr = true, noremap = true })
vim.keymap.set("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . "k"]], { expr = true, noremap = true })

-- visual shifting does not exit visual mode
vim.keymap.set("v", "<", "<gv", default_opts)
vim.keymap.set("v", ">", ">gv", default_opts)

-- repeat operator with a visual selection
vim.keymap.set("v", ".", "<cmd>normal .<cr>", default_opts)

-- really write the file in case of forgotten sudo
vim.keymap.set("c", "w!!", "!sudo tee % >/dev/null", default_opts)

-- moving lines around
vim.keymap.set("n", "<m-j>", "<cmd>m .+1<cr>==", default_opts)
vim.keymap.set("n", "<m-k>", "<cmd>m .-2<cr>==", default_opts)
vim.keymap.set("i", "<m-j>", "<esc><cmd>m .+1<cr>==gi", default_opts)
vim.keymap.set("i", "<m-k>", "<esc><cmd>m .-2<cr>==gi", default_opts)
vim.keymap.set("v", "<m-j>", ":m '>+1<cr>gv=gv", default_opts)
vim.keymap.set("v", "<m-k>", ":m '<-2<cr>gv=gv", default_opts)

vim.keymap.set("n", "<c-u>", "<c-u>zz", default_opts)
vim.keymap.set("n", "<c-d>", "<c-d>zz", default_opts)

-- replace paste in visual mode using black hole register for delete
vim.keymap.set("v", "p", '"_dP', default_opts)

-- easier moving around in insert mode
-- vim.keymap.set("i", "<c-h>", "<c-o>h", default_opts)
-- vim.keymap.set("i", "<c-j>", "<c-o>j", default_opts)
-- vim.keymap.set("i", "<c-k>", "<c-o>k", default_opts)
-- vim.keymap.set("i", "<c-l>", "<c-o>l", default_opts)

-- easy line start/end
vim.keymap.set({ "n", "v", "o", "x" }, "<m-h>", "^", default_opts)
vim.keymap.set({ "n", "v", "o", "x" }, "<m-l>", "$", default_opts)

-- previous/next buffer
vim.keymap.set("n", "<m-n>", "<cmd>bnext<cr>", default_opts)
vim.keymap.set("n", "<m-p>", "<cmd>bprevious<cr>", default_opts)

-- toggle line numbers
vim.keymap.set("n", "<leader><leader>n", require("user.utils").toggleLineNumbers, default_opts)

-- toggle indentation (tabs/spaces)
vim.keymap.set("n", "<leader><leader>i", require("user.utils").toggleIndentation, default_opts)

-- navigate quickfix window
vim.keymap.set("n", "<leader><leader>q", require("user.utils").toggleQuickfixWindow, default_opts)
