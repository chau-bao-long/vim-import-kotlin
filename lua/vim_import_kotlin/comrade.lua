local importkt = require('vim_import_kotlin/importkt')

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

  importkt.prepare()

  for _, import in ipairs(imports) do
		importkt.import(import)
  end
end

return M
