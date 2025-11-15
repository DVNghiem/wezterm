-- ~/.config/wezterm/status/left.lua
local wezterm = require 'wezterm'

wezterm.on('update-status', function(window, pane)
  local cwd = pane:get_current_working_dir()
  if not cwd then return end

  local path = cwd.file_path or ''
  path = path:gsub('^file://[^/]+', '')
  path = path:gsub('%%%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)

  -- Rút gọn path
  local parts = {}
  for part in path:gmatch('[^/]+') do table.insert(parts, part) end
  local short = (#parts > 2) and '…/' .. table.concat({table.unpack(parts, #parts-1)}, '/') or path

  -- Git branch (an toàn)
  local git_branch = ''
  local success, stdout = pcall(function()
    local handle = io.popen('git -C "' .. path .. '" rev-parse --abbrev-ref HEAD 2>/dev/null')
    local output = handle:read('*a')
    handle:close()
    return output
  end)
  if success and stdout and stdout ~= '' then
    git_branch = '  ' .. stdout:gsub('\n', '')
  end

  -- Status bar
  window:set_left_status(wezterm.format {
    { Foreground = { Color = '#33ff00' } },
    { Text = ' ' .. wezterm.hostname() .. ' ' },
    { Foreground = { Color = '#0066ff' } },
    { Text = short .. git_branch .. ' ' },
  })
end)

return function(c) return c end