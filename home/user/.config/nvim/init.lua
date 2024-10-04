-- impatient
_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath("cache") .. "/luacache_chunks",
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
    }
}

local impatient_ok, _ = pcall(require, "impatient")
if not impatient_ok then
    vim.notify("Failed to load impatient.nvim", vim.log.levels.WARN)
end

require "user.settings"
require "user.keybindings"
require "user.autocommands"

require "user.lazy"
