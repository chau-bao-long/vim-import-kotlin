local fzf = require("fzf")
local utils = require('utils')

local M = {}

local import_cache_path = vim.env.HOME .. '/.import.lib'

local function add_line_to_buffer(line)
  if vim.fn.search(line) ~= 0 then return end

  local second_line = vim.fn.getbufline(vim.fn.bufnr(), 2)[1]
  local third_line = vim.fn.getbufline(vim.fn.bufnr(), 3)[1]
  local start_index = string.find(third_line, 'import')
  local has_import_before = start_index == 1

  -- need one blank line after package a.b.c
  if second_line ~= '' then
    vim.fn.appendbufline(vim.fn.bufnr(), 1, '')
  end

  -- make sure has one blank line after import block
  if third_line == '' or has_import_before then
    vim.fn.appendbufline(vim.fn.bufnr(), 2, 'import ' .. line)
  else
    vim.fn.appendbufline(vim.fn.bufnr(), 2, '')
    vim.fn.appendbufline(vim.fn.bufnr(), 2, 'import ' .. line)
  end
end

local function fill_suggestions_from_current_project(matches, current_word)
  local project_data = vim.fn.system('rg -U --with-filename -t kotlin package')
  local suggestions = utils.split(project_data, '\n')

  for _, suggestion in ipairs(suggestions) do
    local tmp = vim.fn.split(suggestion, "/")
    local names = vim.fn.split(tmp[#tmp], ":")
    local classname = utils.split(names[1], ".")[1]

    if current_word == classname then
      local import_line = string.gsub(names[2], "package ", "") .. "." .. classname

      local found = false
      for _, match in ipairs(matches) do
        if match == import_line then
          found = true
          break
        end
      end

      if not found then
        table.insert(matches, import_line)
      end
    end
  end
end

local function fill_suggestions_from_learning_path(matches, current_word)
  for line in io.lines(import_cache_path) do
    local words = utils.split(line, ".")
    local last_word = words[#words]

    if last_word == current_word then
      table.insert(matches, line)
    end
  end
end

function M.import()
  local matches = {}
  local current_word = vim.fn.expand('<cword>')

  fill_suggestions_from_learning_path(matches, current_word)
  fill_suggestions_from_current_project(matches, current_word)

  if (#matches == 1) then
    add_line_to_buffer(matches[1])
  else
    coroutine.wrap(function()
      local result = fzf.fzf(matches, "--ansi", { width = 100, height = 30, })

      if result then
        add_line_to_buffer(result[1])
      end
    end)()
  end
end

return M
