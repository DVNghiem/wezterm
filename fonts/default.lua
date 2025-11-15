local wezterm = require 'wezterm'

return function(c)
  c.font = wezterm.font_with_fallback {
    { family = 'FiraCode Nerd Font', weight = 'Medium' },
    { family = 'JetBrainsMono Nerd Font' },
    'Apple Color Emoji',
  }
  c.font_size = 13.5
  return c
end