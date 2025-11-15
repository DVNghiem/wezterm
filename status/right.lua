local wezterm = require 'wezterm'
local io = require 'io'
local math = require 'math'

-- Function to read CPU usage
local function get_cpu_usage()
  local file = io.open('/proc/stat', 'r')
  if not file then return nil end
  
  local line = file:read('*line')
  file:close()
  
  if not line then return nil end
  
  local user, nice, system, idle = line:match('cpu%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)')
  if not user then return nil end
  
  local total = tonumber(user) + tonumber(nice) + tonumber(system) + tonumber(idle)
  local usage = ((total - tonumber(idle)) / total) * 100
  
  return math.floor(usage)
end

-- Function to read memory usage
local function get_memory_usage()
  local file = io.open('/proc/meminfo', 'r')
  if not file then return nil, nil end
  
  local mem_total, mem_available
  for line in file:lines() do
    if line:match('^MemTotal:') then
      mem_total = tonumber(line:match('%d+'))
    elseif line:match('^MemAvailable:') then
      mem_available = tonumber(line:match('%d+'))
    end
    if mem_total and mem_available then break end
  end
  file:close()
  
  if not mem_total or not mem_available then return nil, nil end
  
  local mem_used = mem_total - mem_available
  local mem_percent = math.floor((mem_used / mem_total) * 100)
  local mem_used_gb = mem_used / 1024 / 1024
  
  return mem_percent, mem_used_gb
end

return function(c)
  wezterm.on('update-status', function(window, pane)
    -- Battery
    local bat = ''
    local bat_percent = 0
    for _, b in ipairs(wezterm.battery_info()) do
      local bat_icon = '󰁹'
      bat_percent = math.floor(b.state_of_charge * 100)
      
      if b.state == 'Charging' then
        bat_icon = '󰂄'
      elseif bat_percent >= 90 then
        bat_icon = '󰁹'
      elseif bat_percent >= 70 then
        bat_icon = '󰂀'
      elseif bat_percent >= 50 then
        bat_icon = '󰁾'
      elseif bat_percent >= 30 then
        bat_icon = '󰁼'
      elseif bat_percent >= 10 then
        bat_icon = '󰁺'
      else
        bat_icon = '󰂎'
      end
      
      bat = string.format('%s %d%%', bat_icon, bat_percent)
    end
    
    -- CPU Usage
    local cpu = get_cpu_usage()
    local cpu_text = ''
    if cpu then
      cpu_text = string.format('󰻠 %d%%', cpu)
    end
    
    -- Memory Usage
    local mem_percent, mem_gb = get_memory_usage()
    local mem_text = ''
    if mem_percent and mem_gb then
      mem_text = string.format('󰍛 %.1fG %d%%', mem_gb, mem_percent)
    end
    
    -- Time
    local time = wezterm.strftime '%H:%M:%S'
    
    -- Tạo status elements
    local elements = {}
    
    -- Battery
    if bat ~= '' then
      local bat_color = '#9ece6a'
      if bat_percent < 20 then
        bat_color = '#f7768e'
      elseif bat_percent < 50 then
        bat_color = '#e0af68'
      end
      table.insert(elements, { Foreground = { Color = bat_color } })
      table.insert(elements, { Text = ' ' .. bat })
    end
    
    -- CPU
    if cpu_text ~= '' then
      local cpu_color = '#7dcfff'
      if cpu and cpu > 80 then
        cpu_color = '#f7768e'
      elseif cpu and cpu > 50 then
        cpu_color = '#e0af68'
      end
      table.insert(elements, { Foreground = { Color = cpu_color } })
      table.insert(elements, { Text = ' | ' .. cpu_text })
    end
    
    -- Memory
    if mem_text ~= '' then
      local mem_color = '#bb9af7'
      if mem_percent and mem_percent > 80 then
        mem_color = '#f7768e'
      elseif mem_percent and mem_percent > 60 then
        mem_color = '#e0af68'
      end
      table.insert(elements, { Foreground = { Color = mem_color } })
      table.insert(elements, { Text = ' | ' .. mem_text })
    end
    
    -- Time
    table.insert(elements, { Foreground = { Color = '#c0caf5' } })
    table.insert(elements, { Text = ' | 󰥔 ' .. time .. ' ' })
    
    window:set_right_status(wezterm.format(elements))
  end)
  
  return c
end