local wezterm = require 'wezterm'
local act = wezterm.action

return function(c)
  c.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
  c.keys = c.keys or {}
  table.insert(c.keys, { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey { key = 'a', mods = 'CTRL' } })
  return c
end