-- PULL IN WEZTERM APIS
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- PERFORMANCE & RENDERING
-- These settings are critical for startup speed and responsiveness.
config.front_end = "OpenGL" -- Use the most stable and performant renderer on Windows.
config.max_fps = 60         -- Cap FPS at a reasonable rate to reduce GPU load.
config.animation_fps = 1    -- Drastically reduce FPS for animations (e.g., blinking cursor) to save power.

-- FONT CONFIGURATION
config.font_size = 12.5
config.font = wezterm.font("Iosevka Nerd Font Propo")

-- TERMINAL BEHAVIOR
config.term = "xterm-256color"      -- Identify as a 256-color 
config.default_prog = { "powershell.exe", "-NoLogo" } 
config.default_cursor_style = "SteadyUnderline"
config.cursor_blink_rate = 300

-- APPEARANCE & THEME
-- Window Decorations & Tabs
config.window_decorations = "NONE | RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false 
config.window_padding = { left = 1, right = 0, top = 1, bottom = 0 }

-- Colors & Opacity
config.color_scheme = "Cloud (terminal.sexy)"
config.window_background_opacity = 1.0
config.colors = {
    background = "#0c0b0f",
    cursor_bg = "#bea3c7",
    cursor_border = "#bea3c7",

    tab_bar = {
        background = "#0c0b0f",
        active_tab = {
            bg_color = "#0c0b0f",
            fg_color = "#bea3c7",
        },
        inactive_tab = {
            bg_color = "#0c0b0f",
            fg_color = "#f8f2f5",
        },
        new_tab = {
            bg_color = "#0c0b0f",
            fg_color = "white",
        },
    },
}

-- Custom Titlebar Color
config.window_frame = {
    active_titlebar_bg = "#0c0b0f",
}

-- KEY BINDINGS
config.keys = {

    -- Pane Management
    { key = "v", mods = "CTRL|SHIFT|ALT", action = act.SplitPane({ direction = "Down",  size = { Percent = 50 } }) },
    { key = "h", mods = "CTRL|SHIFT|ALT", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },
    { key = "w", mods = "CTRL|SHIFT",     action = act.CloseCurrentPane { confirm = true } },

    -- Pane Resizing
    { key = "P", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
    { key = "U", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "O", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "I", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
    
    -- Tab Management
    { key = "n", mods = "CTRL|SHIFT", action = act.SpawnTab 'CurrentPaneDomain' },
    { key = "w", mods = "CTRL",       action = wezterm.action.CloseCurrentTab { confirm = true } },

    -- Utility
    { key = "9", mods = "CTRL", action = act.PaneSelect },
    { key = "L", mods = "CTRL", action = act.ShowDebugOverlay },

    -- Dynamic Opacity Toggle
    {
        key = "O",
        mods = "CTRL|ALT",
        action = wezterm.action_callback(function(window, _)
            local overrides = window:get_config_overrides() or {}
            if overrides.window_background_opacity == 1.0 then
                overrides.window_background_opacity = 0.7
            else
                overrides.window_background_opacity = 1.0
            end
            window:set_config_overrides(overrides)
        end),
    },
}

return config
