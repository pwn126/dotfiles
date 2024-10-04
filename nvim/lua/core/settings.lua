local indent = 4
local textwidth = 100

vim.g.netrw_altv = 1
vim.g.netrw_alto = 0
vim.g.netrw_banner = 0
-- vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_preview = 1
-- vim.g.netrw_winsize = 25

vim.opt.breakindent = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.cmdheight = 1
vim.opt.colorcolumn = tostring(textwidth + 1)
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.foldenable = false
vim.opt.formatoptions = "cnqj2"
vim.opt.history = 500
vim.opt.ignorecase = true
vim.opt.iskeyword:append("-")
vim.opt.inccommand = "split"
vim.opt.lazyredraw = true
vim.opt.listchars:append("trail:⋅")
vim.opt.listchars:append("precedes:«")
vim.opt.listchars:append("extends:»")
vim.opt.listchars:append("tab: ▸")
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("lead:⋅")
vim.opt.listchars:append("space:⋅")
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.shiftround = true
vim.opt.shiftwidth = indent
vim.opt.shortmess:append("c")
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.spelllang = "en_us,de"
vim.opt.softtabstop = indent
vim.opt.swapfile = false
vim.opt.tabstop = indent
vim.opt.termguicolors = true
vim.opt.textwidth = textwidth
vim.opt.title = true
vim.opt.titlestring = "%t%( %M%)%( (%{expand('%:~:.:h')})%)"
vim.opt.updatetime = 300
vim.opt.whichwrap:append("<", ">", "[", "]")
vim.opt.wrap = false
vim.opt.writebackup = false

-- vim.lsp.set_log_level("debug")
