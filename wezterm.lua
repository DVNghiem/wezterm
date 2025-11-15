-- ~/.config/wezterm/wezterm.lua
local wezterm = require 'wezterm'
require 'utils.hot_reload'

local config = {}

-- === FONT ===
config.font = wezterm.font_with_fallback {
  'FiraCode Nerd Font', 'JetBrainsMono Nerd Font', 'Noto Color Emoji'
}
config.font_size = 13.0
config.harfbuzz_features = { 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03' }

-- === TRANSPARENCY + BG IMAGE ===
config.window_background_opacity = 0.92
config.macos_window_background_blur = 30
-- config.window_background_image = os.getenv('HOME') .. '/.config/wezterm/bg/dev-bg.jpg'
-- config.window_background_image_hsb = {
--   brightness = 0.03,
--   hue = 1.0,
--   saturation = 0.9,
-- }

-- === TAB BAR ===
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- === STATUS BAR (FULL STATS) ===
config = require 'status.left'(config)
config = require 'status.right'(config)

-- === KEYBINDS ===
config = require 'keybinds.leader'(config)
config = require 'keybinds.panes'(config)
config = require 'keybinds.tabs'(config)
config = require 'keybinds.misc'(config)

-- === THEME (HYPER - giữ nguyên) ===
config = require 'colors.hyper'(config)

-- === UI TỐI ƯU ===
config.inactive_pane_hsb = { saturation = 0.7, brightness = 0.8 }
config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = true
config.status_update_interval = 2000  -- 2 giây (giảm lag)
config.adjust_window_size_when_changing_font_size = false

return config