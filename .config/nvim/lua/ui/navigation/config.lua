local M = {}

local grapple = require 'grapple'
-- local icon = '󰛢'
local icon = '󰍎'

M.lualine = {}

M.lualine.fmt = function(str)
  return string.format(' %s ', str)
end

local minify_path = function(path) end
M.lualine.get_grapple_tag = function(args)
  local g = require 'grapple'
  return function()
    local e = g.exists { scope = args.scope, index = args.index }
    local tag = g.find { scope = args.scope, index = args.index }
    return string.format('(%s) %s', args.index, e and tag.path)
  end
end

M.lualine.unpack_grapple_statusline = function(args)
  local component = {}

  for i = 1, 10 do
    local check = require('grapple').exists { scope = 'git', index = i }
    component[i] = {
      -- tag and command or tag,
      check and string.format('require("ui.navigation.config").lualine.get_grapple_tag{ index = %s, scope = %s  }', i, args.scope)
        or M.lualine.get_grapple_tag { scope = 'git', index = i },
      color = check and 'Search' or 'TelescopeResultsNormal',
    }
  end

  return unpack(component)
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
