vim.loader.enable()

require("core.settings")
require("core.keybindings")
require("core.autocommands")
require("core.utils")

-- bootstrap lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
if lazy_ok then
    lazy.setup({
        { import = "plugins" },
        { import = "plugins.colorschemes" },
    }, {
        -- check for plugin updates and notify
        checker = {
            enable = true,
            notify = true,
        },
        -- check for config updates to update the UI but do not notify
        change_detection = {
            notify = false,
        },
        ui = {
            border = "rounded",
        },
    })
else
    vim.notify("Lazy failed to setup plugins", vim.log.levels.ERROR)
end
