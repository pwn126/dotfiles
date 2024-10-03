local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_ok then
    return
end

autopairs.setup {
    check_ts = true,
    disable_filetype = { "TelescopePrompt" },
    fast_wrap = {
        map = "<m-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
}

local cmp_status_ok, cmp = pcall(require, "cmp")
if cmp_status_ok then
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
end
