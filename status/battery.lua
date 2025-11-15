local wezterm = require 'wezterm'
return function(c)
  wezterm.on('update-status', function(window, _)
    local bat = ''
    for _, b in ipairs(wezterm.battery_info()) do
      bat = string.format('%.0f%%', b.state_of_charge * 100)
      break
    end
    if bat ~= '' then
      local color = (tonumber(bat:match '%d+') or 0) < 20 and '#ff5555' or '#f1fa8c'
      window:set_right_status(wezterm.format{
        {Foreground={Color=color}},
        {Text='  '..bat..'  '},
      })
    end
  end)
  return c
end