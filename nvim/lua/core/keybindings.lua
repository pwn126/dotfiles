-- leader key is space
vim.g.mapleader = " "

vim.keymap.set({ "i", "c" }, "<c-c>", "<ESC>", {
    desc = "Ctrl-c is same as Esc",
})
vim.keymap.set({ "i", "c" }, "jj", "<ESC>", {
    desc = "jj is same as Esc",
})
vim.keymap.set({ "i", "c" }, "kk", "<ESC>", {
    desc = "kk is same as Esc",
})
vim.keymap.set("", "j", "gj", {
    desc = "Wrapped lines goes down to next row, rather than next line in file",
})
vim.keymap.set("", "k", "gk", {
    desc = "Wrapped lines goes up to next row, rather than next line in file",
})
vim.keymap.set("n", "<leader>gc", "/\\v^[<\\|=\\|>]{7}( .*|$)<cr>", {
    desc = "Find git merge conflict markers",
})
vim.keymap.set("n", "<leader>bd", ":b#<bar>bd#<cr>", {
    desc = "Close buffer without closing the split",
})
vim.keymap.set("n", "Y", "y$", {
    desc = "Yank from current position to end of line",
})
vim.keymap.set("n", "n", "nzzzv", {
    desc = "Keep cursor line in one place when skipping around or joining lines",
})
vim.keymap.set("n", "N", "Nzzzv", {
    desc = "Keep cursor line in one place when skipping around or joining lines",
})
vim.keymap.set("n", "J", "mzJ'z", {
    desc = "Keep cursor line in one place when skipping around or joining lines",
})
vim.keymap.set("i", ",", ",<c-g>u", {
    desc = "Add more undo break points",
})
vim.keymap.set("i", ".", ".<c-g>u", {
    desc = "Add more undo break points",
})
vim.keymap.set("i", "!", "!<c-g>u", {
    noremap = true,
    desc = "Add more undo break points",
})
vim.keymap.set("i", "?", "?<c-g>u", {
    noremap = true,
    desc = "Add more undo break points",
})
vim.keymap.set("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . "j"]], {
    expr = true,
    desc = "More detailed jump list",
})
vim.keymap.set("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . "k"]], {
    expr = true,
    noremap = true,
    desc = "More detailed jump list",
})
vim.keymap.set("n", "<leader>rt", ":%retab!<cr>", {
    desc = "Update/fix indentation in current buffer",
})
vim.keymap.set("v", "<", "<gv", {
    desc = "Indentation shift left does not exit visual mode",
})
vim.keymap.set("v", ">", ">gv", {
    desc = "Indentation shift right does not exit visual mode",
})
vim.keymap.set("v", ".", "<cmd>normal .<cr>", {
    desc = "Repeat operator with a visual selection",
})
vim.keymap.set("c", "w!!", "!sudo tee % >/dev/null", {
    desc = "Really wright a file in case of forgotten sudo",
})
vim.keymap.set("n", "<c-j>", "<cmd>m .+1<cr>==", {
    desc = "Move line down",
})
vim.keymap.set("n", "<c-k>", "<cmd>m .-2<cr>==", {
    desc = "Move line up",
})
vim.keymap.set("i", "<c-j>", "<esc><cmd>m .+1<cr>==gi", {
    desc = "Move line down",
})
vim.keymap.set("i", "<c-k>", "<esc><cmd>m .-2<cr>==gi", {
    desc = "Move line up",
})
vim.keymap.set("v", "<c-j>", ":m '>+1<cr>gv=gv", {
    desc = "Move line down",
})
vim.keymap.set("v", "<c-k>", ":m '<-2<cr>gv=gv", {
    desc = "Move line up",
})
vim.keymap.set("n", "<c-u>", "<c-u>zz", {
    desc = "Scroll up with centered cursor line",
})
vim.keymap.set("n", "<c-d>", "<c-d>zz", {
    desc = "Scroll down with centered cursor line",
})
vim.keymap.set("v", "p", '"_dP', {
    desc = "Replace paste in visual mode using black hole register for delete",
})
vim.keymap.set({ "n", "v", "o", "x" }, "<c-h>", "^", {
    desc = "Go to line start",
})
vim.keymap.set({ "n", "v", "o", "x" }, "<c-l>", "$", {
    desc = "Go to line end",
})
vim.keymap.set("n", "<c-n>", "<cmd>bnext<cr>", {
    desc = "Next buffer",
})
vim.keymap.set("n", "<c-p>", "<cmd>bprevious<cr>", {
    desc = "Previous buffer",
})
vim.keymap.set("n", "sa", "zg", {
    desc = "Add new word to spelling dictionary",
})
vim.keymap.set("n", "sf", "z=", {
    desc = "Get suggestions to fix spelling",
})
vim.keymap.set("n", "sn", "]s", {
    desc = "Go to next missspelling",
})
vim.keymap.set("n", "sp", "[s", {
    desc = "Go to previous missspelling",
})
vim.keymap.set("n", "<leader>ts", require("core.utils").toggleSpellChecking, {
    desc = "Toggle spell checking",
})
vim.keymap.set("n", "<leader>th", ":set hlsearch!<cr>", {
    desc = "Toggle search highlighting",
})
vim.keymap.set("n", "<leader>tl", ":set list!<cr>", {
    desc = "Toggle list characters",
})
vim.keymap.set("n", "<leader>tn", require("core.utils").toggleLineNumbers, {
    desc = "Toggle line numbers (relative, absolute, off)",
})
vim.keymap.set("n", "<leader>ti", require("core.utils").toggleIndentation, {
    desc = "Toggle indentation (spaces, tabs)",
})
vim.keymap.set("v", "<leader>rn", '"hy:%s/<c-r>h//g<left><left>', {
    desc = "Replace visually highlighted term",
})
vim.keymap.set("n", "<leader><leader>T", "<cmd>Lexplore %:p:h<cr>", {
    desc = "Open netrw in the directory of the current file",
})
vim.keymap.set("n", "<leader><leader>t", "<cmd>20Lexplore<cr>", {
    desc = "Open netrw in the current working directory",
})
vim.keymap.set("n", "<leader>cq", require("core.utils").toggleQuickfixWindow, {
    desc = "Open/close quickfix windows",
})
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<cr>zz", {
    desc = "Go to next item from quick fix list",
})
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<cr>zz", {
    desc = "Go to previous item from quick fix list",
})
vim.keymap.set("n", "<leader>cf", "<cmd>cfirst<cr>zz", {
    desc = "Go to first item from quick fix list",
})
vim.keymap.set("n", "<leader>cl", "<cmd>clast<cr>zz", {
    desc = "Go to last item from quick fix list",
})
vim.keymap.set("n", "Q", "@qj", {
    desc = "Playback the macro from the q register",
})
vim.keymap.set("x", "Q", "<cmd>norm @q<cr>", {
    desc = "Playback the macro from the q register on a visual selection",
})
vim.keymap.set("t", "jj", "<C-\\><C-n>", {
    desc = "Exit terminal mode"
})
