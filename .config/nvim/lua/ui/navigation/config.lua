local M = {}

local grapple = require 'grapple'
-- local icon = '󰛢'
local icon = '󰍎'

M.lualine = {}

M.lualine.fmt = function(str)
  return string.format(' %s ', str)
end

local get_grapple_taglist = function()
  local taglist = grapple.tags()
end

M.lualine.get_grapple_component = function()
  local taglist = grapple.tags { scope = 'git' }
  local color = 'TelescopeResultsNormal'
  local component = {}

  if taglist then
    for i, _ in pairs(taglist) do
      table.insert(component, {
        function()
          local tag = require('grapple').find { index = i, scope = 'git' }
          local path = tag and tag.path or ' '
          path = path:gsub('.*/', '')
          local result = string.format('%s %s', i, path)
          return tag and result
        end,
        color = color,
      })
    end
  end

  return component
end

M.incline = {}

M.incline.buf_info = function(bfnr)
  bfnr = { buffer = bfnr }
  local exists = grapple.exists(bfnr)
  local tag = grapple.name_or_index(bfnr)
  -- tag = string.format('%s%s', icon, tag)
  local result = exists and tag or icon
  result = string.format(' %s ', result)
  local group = exists and 'InclineTag' or 'InclineDim'
  return { result, group = group }
end

return M
