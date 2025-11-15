local act = require 'wezterm'.action
return function(c)
  local k = {
    { key = 'c',   mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w',   mods = 'LEADER', action = act.CloseCurrentTab { confirm = false } },
    { key = '[',   mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    { key = ']',   mods = 'LEADER', action = act.ActivateTabRelative(1) },
  }
  c.keys = require('utils.helpers').merge_keys(c.keys, k)
  return c
end