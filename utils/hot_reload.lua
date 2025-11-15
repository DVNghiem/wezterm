local wezterm = require 'wezterm'
wezterm.on('window-config-reloaded', function(window, pane)
  wezterm.log_info 'Config hot‑reloaded!'
  window:toast_notification('WezTerm', 'Config reloaded', nil, 2000)
end)