local wezterm = require 'wezterm'
local act = wezterm.action

return function(c)
  c.keys = c.keys or {}

  -- Leader + 1,2,3,...  switch workspace
  local workspace_keys = {
    { key = '1', mods = 'LEADER', action = act.SwitchToWorkspace { name = 'default' } },
    { key = '2', mods = 'LEADER', action = act.SwitchToWorkspace { name = 'dev' } },
    { key = '3', mods = 'LEADER', action = act.SwitchToWorkspace { name = 'k8s' } },
    { key = '4', mods = 'LEADER', action = act.SwitchToWorkspace { name = 'logs' } },
  }

  for _, k in ipairs(workspace_keys) do
    table.insert(c.keys, k)
  end

  wezterm.on('user-var-changed', function(window, pane, name, value)
    if name == 'wezterm_gui_startup' then
      local workspaces = wezterm.gui and wezterm.gui.get_workspace_names() or {}
      local desired = { 'default', 'dev', 'k8s', 'logs' }
      for _, ws in ipairs(desired) do
        if not wezterm.gui.get_workspace_by_name(ws) then
          wezterm.gui.new_workspace(ws)
        end
      end
    end
  end)

  return c
end