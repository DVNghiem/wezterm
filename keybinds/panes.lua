local act = require 'wezterm'.action
return function(c)
  local k = {
    { key = '-', mods = 'LEADER',       action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'h', mods = 'LEADER',       action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'LEADER',       action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'LEADER',       action = act.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'LEADER',       action = act.ActivatePaneDirection 'Right' },
    { key = 'x', mods = 'LEADER',       action = act.CloseCurrentPane { confirm = true } },
  }
  c.keys = require('utils.helpers').merge_keys(c.keys, k)
  return c
end