local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- config.debug_key_events = true

-- font
config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 13.0

-- tab bar
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- key bindings
config.disable_default_key_bindings = true

config.keys = {
    {
        key = "t",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
        key = "q",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CloseCurrentTab({ confirm = false }),
    },
    {
        key = "c",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
    },
    {
        key = "v",
        mods = "CTRL|SHIFT",
        action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
        key = "raw:21",
        mods = "CTRL|SHIFT",
        action = wezterm.action.IncreaseFontSize,
    },
    {
        key = "-",
        mods = "CTRL",
        action = wezterm.action.DecreaseFontSize,
    },
    {
        key = "0",
        mods = "CTRL",
        action = wezterm.action.ResetFontSize,
    },
    {
        key = "raw:10",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTab(0),
    },
    {
        key = "raw:11",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTab(1),
    },
    {
        key = "raw:12",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTab(2),
    },
    {
        key = "raw:13",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTab(3),
    },
    {
        key = "raw:14",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTab(4),
    },
    {
        key = "raw:15",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTab(5),
    },
    {
        key = "raw:16",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTab(6),
    },
    {
        key = "raw:17",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTab(7),
    },
    {
        key = "raw:18",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTab(8),
    },
    {
        key = "Enter",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "Enter",
        mods = "CTRL|SHIFT|ALT",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "h",
        mods = "ALT",
        action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
        key = "l",
        mods = "ALT",
        action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
        key = "k",
        mods = "ALT",
        action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
        key = "j",
        mods = "ALT",
        action = wezterm.action.ActivatePaneDirection("Down"),
    },
}

return config
