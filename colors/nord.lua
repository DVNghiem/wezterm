-- ~/.config/wezterm/colors/nord.lua
local wezterm = require 'wezterm'

local nord = {
  -- Nord Palette[](https://www.nordtheme.com/docs/colors-and-palettes)
  polar_night = {
    nord0 = "#2E3440",  -- Background
    nord1 = "#3B4252",
    nord2 = "#434C5E",
    nord3 = "#4C566A",
  },
  snow_storm = {
    nord4 = "#D8DEE9",  -- Foreground
    nord5 = "#E5E9F0",
    nord6 = "#ECEFF4",
  },
  frost = {
    nord7 = "#8FBCBB",
    nord8 = "#88C0D0",
    nord9 = "#81A1C1",
    nord10 = "#5E81AC",
  },
  aurora = {
    nord11 = "#BF616A",  -- Red
    nord12 = "#D08770",  -- Orange
    nord13 = "#EBCB8B",  -- Yellow
    nord14 = "#A3BE8C",  -- Green
    nord15 = "#B48EAD",  -- Purple
  },
}

local function apply_nord(c, is_dark)
  local scheme = is_dark and "Nord (Dark)" or "Nord (Light)"

  -- Nếu dùng built-in scheme (WezTerm có sẵn Nord)
  if wezterm.color.get_builtin_schemes()[scheme] then
    c.color_scheme = scheme
    return c
  end

  -- Custom scheme nếu không có built-in
  c.colors = {
    foreground = is_dark and nord.snow_storm.nord4 or nord.polar_night.nord0,
    background = is_dark and nord.polar_night.nord0 or nord.snow_storm.nord6,

    cursor_bg = nord.frost.nord8,
    cursor_fg = nord.polar_night.nord0,
    cursor_border = nord.frost.nord8,

    selection_fg = nord.polar_night.nord0,
    selection_bg = nord.frost.nord9,

    scrollbar_thumb = nord.polar_night.nord3,
    split = nord.polar_night.nord3,

    ansi = {
      nord.polar_night.nord1,  -- black
      nord.aurora.nord11,      -- red
      nord.aurora.nord14,      -- green
      nord.aurora.nord13,      -- yellow
      nord.frost.nord10,       -- blue
      nord.aurora.nord15,      -- magenta
      nord.frost.nord8,        -- cyan
      nord.snow_storm.nord5,   -- white
    },

    brights = {
      nord.polar_night.nord3,  -- bright black
      nord.aurora.nord11,      -- bright red
      nord.aurora.nord14,      -- bright green
      nord.aurora.nord13,      -- bright yellow
      nord.frost.nord9,        -- bright blue
      nord.aurora.nord15,      -- bright magenta
      nord.frost.nord7,        -- bright cyan
      nord.snow_storm.nord6,   -- bright white
    },

    tab_bar = {
      background = is_dark and nord.polar_night.nord1 or nord.snow_storm.nord5,

      active_tab = {
        bg_color = nord.frost.nord10,
        fg_color = nord.snow_storm.nord6,
      },

      inactive_tab = {
        bg_color = nord.polar_night.nord2,
        fg_color = nord.snow_storm.nord4,
      },

      inactive_tab_hover = {
        bg_color = nord.polar_night.nord3,
        fg_color = nord.snow_storm.nord5,
      },

      new_tab = {
        bg_color = nord.polar_night.nord1,
        fg_color = nord.snow_storm.nord4,
      },

      new_tab_hover = {
        bg_color = nord.frost.nord8,
        fg_color = nord.polar_night.nord0,
      },
    },
  }

  return c
end

return function(c)
  local appearance = wezterm.gui and wezterm.gui.get_appearance() or 'Dark'
  local is_dark = appearance:find 'Dark'
  return apply_nord(c, is_dark)
end