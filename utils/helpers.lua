local M = {}

function M.merge_keys(base, new)
  base = base or {}
  for _,v in ipairs(new) do table.insert(base, v) end
  return base
end

return M