local act = require 'wezterm'.action
return function(c)
  local k = {
    { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
    { key = 'f', mods = 'LEADER',     action = act.Search { CaseSensitiveString = '' } },
    { key = 'p', mods = 'LEADER',     action = act.ActivateCommandPalette },
  }
  c.keys = require('utils.helpers').merge_keys(c.keys, k)
  return c
end