-- ~/.config/wezterm/status/left.lua
local wezterm = require 'wezterm'

-- Format tab title to show only directory name or shortened path
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local cwd = pane.current_working_dir
  
  if not cwd then
    return tab.active_pane.title
  end

  local path = cwd.file_path or ''
  path = path:gsub('^file://[^/]+', '')
  path = path:gsub('%%%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
  
  -- Get just the directory name
  local dir_name = path:match('([^/]+)/?$') or path
  
  -- Replace home directory with ~
  dir_name = dir_name:gsub('^' .. os.getenv('HOME'), '~')
  
  -- Limit length to 20 characters
  if #dir_name > 20 then
    dir_name = dir_name:sub(1, 17) .. '...'
  end
  
  -- Add tab index
  local title = string.format(' %d: %s ', tab.tab_index + 1, dir_name)
  
  return title
end)

wezterm.on('update-status', function(window, pane)
  -- Safely get current working directory with error handling
  local success, cwd = pcall(function()
    return pane:get_current_working_dir()
  end)
  
  if not success or not cwd then return end

  local path = cwd.file_path or ''
  path = path:gsub('^file://[^/]+', '')
  path = path:gsub('%%%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)

  -- Rút gọn path
  local parts = {}
  for part in path:gmatch('[^/]+') do table.insert(parts, part) end
  local short = (#parts > 2) and '…/' .. table.concat({table.unpack(parts, #parts-1)}, '/') or path

  -- Git branch (an toàn)
  local git_branch = ''
  local git_success, stdout = pcall(function()
    local handle = io.popen('git -C "' .. path .. '" rev-parse --abbrev-ref HEAD 2>/dev/null')
    local output = handle:read('*a')
    handle:close()
    return output
  end)
  if git_success and stdout and stdout ~= '' then
    git_branch = '  ' .. stdout:gsub('\n', '')
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
