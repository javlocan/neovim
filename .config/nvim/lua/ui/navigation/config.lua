local M = {}

local grapple = require 'grapple'
-- local icon = '󰛢'
local icon = '󰍎'

M.lualine = {}

M.lualine.fmt = function(str)
  return string.format(' %s ', str)
end

local escape = function(s)
  return string.gsub(s, '[.*+?^$()[%%-]', '%%%0')
end

local minify_path = function(path)
  local root = string.format([[%s/]], escape(vim.loop.cwd()))
  return string.gsub(path, root, '')
end

M.lualine.get_grapple_tag = function(args)
  local g = require 'grapple'

  local exists = g.exists { scope = args.scope, index = args.index }
  local tag = g.find { scope = args.scope, index = args.index }

  local path = exists and minify_path(tag.path) or ''
  local nc_pattern = ' [%s]'
  return exists and string.format(' %s %s ', args.index, path) or string.format(nc_pattern, args.index)
end

M.lualine.unpack_grapple_statusline = function(args)
  local component = {}

  for i = 1, 10 do
    local command = string.format('require("ui.navigation.config").lualine.get_grapple_tag{ index = %s, scope = %s  }', i, args.scope)
    local color = function()
      local check = require('grapple').exists { scope = args.scope, index = i }
      return check and 'StatusLine' or 'StatusLineNC'
    end
    -- component[i] = {
    --   command,
    --   color = color,
    --   padding = { left = 0, right = 0 },
    -- }
    table.insert(component, {
      command,
      color = color,
      padding = { left = 0, right = 0 },
    })
    local exists = require('grapple').exists { scope = args.scope, index = i }
    if exists then
      table.insert(component, {
        command,
        color = color,
        padding = { left = 0, right = 0 },
      })
    end
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
  local group = exists and 'StatusLineTag' or 'StatusLineDim'
  return { result, group = group }
end

return M
