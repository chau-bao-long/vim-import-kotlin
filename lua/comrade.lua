local importkt = require('importkt')

local M = {}

function M.import()
  local insights = vim.fn['comrade#bvar#get'](vim.fn.bufnr(''), 'insight_map')
  local imports = {}

  for _, insight in pairs(insights) do
    for _, item in ipairs(insight) do
      for key, value in pairs(item) do
        if key == 'desc' and string.find(value, 'Unresolved reference: ') ~= nil then
          local import_candidate = string.gsub(value, "Unresolved reference: ", "")
          table.insert(imports, import_candidate)
        end
      end
    end
  end

	-- Currently, only run the first candidate
		importkt.import(imports[1])
end

return M
