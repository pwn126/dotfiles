local catppuccin_ok, catppuccin = pcall(require, "catppuccin.palettes")
local onenord_ok, onenord = pcall(require, "onenord.colors")

local colors = {}

if catppuccin_ok and vim.g.my_colorscheme == "catppuccin" then
    colors = catppuccin.get_palette()
elseif onenord_ok and vim.g.my_colorscheme == "onenord" then
    colors = onenord.load()
end

return colors
