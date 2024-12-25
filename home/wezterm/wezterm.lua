local wezterm = require 'wezterm'
local config = {}

-- Set the color scheme
config.color_scheme = 'Tokyo Night Storm (Gogh)'

-- Configure the font
config.font = wezterm.font("JetBrains Mono") -- Set JetBrains Mono as the font
config.font_size = 12.0 -- Adjust the font size

-- Configure cursor style
config.default_cursor_style = "BlinkingBar"

-- Customize the tab bar colors
config.colors = {
  tab_bar = {
    background = "#1a1b26", -- Background of the tab bar

    active_tab = {
      bg_color = "#7aa2f7", -- Background color of the active tab
      fg_color = "#1a1b26", -- Foreground color (text) of the active tab
      italic = false,
    },

    inactive_tab = {
      bg_color = "#414868", -- Background color of inactive tabs
      fg_color = "#c0caf5", -- Foreground color (text) of inactive tabs
    },

    inactive_tab_hover = {
      bg_color = "#565f89", -- Background color when hovering over an inactive tab
      fg_color = "#c0caf5", -- Foreground color when hovering over an inactive tab
      italic = true,
    },

    new_tab = {
      bg_color = "#1a1b26", -- Background color of the "new tab" button
      fg_color = "#7aa2f7", -- Foreground color of the "new tab" button
    },

    new_tab_hover = {
      bg_color = "#7aa2f7", -- Background color when hovering over the "new tab" button
      fg_color = "#1a1b26", -- Foreground color when hovering over the "new tab" button
    },
  },
}
-- Return the configuration
return config
