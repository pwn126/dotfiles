local indent = 4
local textwidth = 100

vim.opt.backup = false -- no backup before saving
vim.opt.clipboard = "unnamedplus" -- copy paste between vim and everything else
vim.opt.cmdheight = 1
vim.opt.colorcolumn = tostring(textwidth + 1) -- colorized column
vim.opt.completeopt = { "menu", "menuone" } -- completion menu behavior
vim.opt.cursorline = true -- enable highlighting of the current line
vim.opt.expandtab = true -- converts tabs to spaces
vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.foldenable = false -- open all foldings by default
vim.opt.formatoptions = "cnqj2" -- format options see fo-table
vim.opt.hidden = true -- allow switching buffers without saving
vim.opt.history = 500 -- store more command history
vim.opt.ignorecase = true -- case insensitive search
vim.opt.iskeyword:append("-")
vim.opt.inccommand = "split" -- show command results incrementally and also in a preview window
vim.opt.joinspaces = false -- always insert just one space on joining two lines
vim.opt.lazyredraw = true -- don't redraw when executing macros
vim.opt.listchars = { trail = "⋅", precedes = "«", extends = "»", tab = " ▸", eol = "↴", lead = "⋅", space = "⋅" }
vim.opt.number = true -- line numbers
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.relativenumber = true -- relative line numbers
vim.opt.scrolloff = 4 -- min. number of lines to keep when scrolling up and down
vim.opt.sidescrolloff = 4 -- min. number of columns to keep when scrolling to the side
vim.opt.signcolumn = "yes" -- always show the signcolumn, otherwise it would shift the text each time
vim.opt.shiftround = true -- round indent to multiple of shiftwidth
vim.opt.shiftwidth = indent -- shift width in columns
vim.opt.shortmess:append("c")
vim.opt.showmatch = true -- show matching brackets/parenthesis
vim.opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.opt.smartcase = true -- case sensitive searhc if upper case present
vim.opt.smartindent = true -- smart indentation
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.splitright = true -- Vertical splits will automatically be to the right
vim.opt.softtabstop = indent -- keep tabstop settings consistent when inserting tabs
vim.opt.swapfile = false -- no swap files
vim.opt.tabstop = indent -- number of spaces which makes a tab
vim.opt.termguicolors = true -- enable 24-bit RGB color in the TUI
vim.opt.textwidth = textwidth -- automatic line break
vim.opt.title = true -- set window title to "titlestring"
vim.opt.titlestring = "%t%( %M%)%( (%{expand('%:~:.:h')})%)"
vim.opt.updatetime = 300 -- Faster completion
vim.opt.whichwrap:append("<", ">", "[", "]", "h", "l")
vim.opt.wrap = false -- don't wrap long lines
vim.opt.writebackup = false -- no backup before overwriting a file


-- vim.lsp.set_log_level("debug")

-- mask unwanted messages
local banned_messages = {
    "warning: multiple different client offset_encodings",
}

local notify = vim.notify
vim.notify = function(msg, ...)
    for _, banned in ipairs(banned_messages) do
        if msg:match(banned) then
            return
        end
    end
    notify(msg, ...)
end
