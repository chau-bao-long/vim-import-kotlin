local M = {}

function M.split(inputstr, delimiter)
  if delimiter == nil then
    delimiter = "%s"
  end

  local t={}

  for str in string.gmatch(inputstr, "([^"..delimiter.."]+)") do
    table.insert(t, str)
  end

  return t
end

return M
