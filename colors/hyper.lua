-- ~/.config/wezterm/colors/hyper.lua
-- 100% Hyper Theme (from your TOML)
-- Author: @vannghiem848 – VN Terminal God

return function(c)
  c.color_scheme = nil  -- Tắt built-in

  c.colors = {
    -- Primary
    background = '#000000',
    foreground = '#ffffff',

    -- Cursor
    cursor_bg = '#ffffff',
    cursor_fg = '#F81CE5',
    cursor_border = '#ffffff',

    -- Selection
    selection_bg = '#0066ff',
    selection_fg = '#ffffff',

    -- ANSI Normal
    ansi = {
      '#000000', -- black
      '#fe0100', -- red
      '#33ff00', -- green     ← PROMPT XANH NEON
      '#feff00', -- yellow
      '#0066ff', -- blue
      '#cc00ff', -- magenta
      '#00ffff', -- cyan
      '#d0d0d0', -- white
    },

    -- ANSI Bright
    brights = {
      '#808080', -- bright black
      '#fe0100', -- bright red
      '#33ff00', -- bright green
      '#feff00', -- bright yellow
      '#0066ff', -- bright blue
      '#cc00ff', -- bright magenta
      '#00ffff', -- bright cyan
      '#FFFFFF', -- bright white
    },

    -- Tab bar (giống Hyper)
    tab_bar = {
      background = '#000000',

      active_tab = {
        bg_color = '#33ff00',  -- Xanh lá neon
        fg_color = '#000000',
      },

      inactive_tab = {
        bg_color = '#1a1a1a',
        fg_color = '#d0d0d0',
      },

      inactive_tab_hover = {
        bg_color = '#333333',
        fg_color = '#ffffff',
      },

      new_tab = {
        bg_color = '#1a1a1a',
        fg_color = '#d0d0d0',
      },

      new_tab_hover = {
        bg_color = '#33ff00',
        fg_color = '#000000',
      },
    },
  }

  return c
end