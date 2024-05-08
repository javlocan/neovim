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

local get_clean_path = function(path)
  local root = string.format([[%s/]], escape(vim.loop.cwd()))
  return string.gsub(path, root, '')
end

M.lualine.get_grapple_tag_index = function(args)
  local g = require 'grapple'

  local global = string.format('grapple_index_%s', args.index)
  local grapple_index = vim.g[global]

  if grapple_index == nil then
    local index = string.format('%s', args.index)
    vim.g[global] = index
  end

  local get_index = function()
    -- Ahora mismo actualizo un monton dem ovidas...
    -- deberia updateaar solo el current buf index ???
    -- o lo mismo se puede hacer todo esto con un autocmd en filetype o bufenter o en lspattach
    local update_index = function()
      local index = string.format('%s', args.index)
      local current_index = vim.api.nvim_win_get_buf(0)
      local current = g.find { scope = args.scope, buffer = current_index }
      local current_path = current and current.path
      local tag = g.find { scope = args.scope, index = args.index }
      local tag_path = tag and tag.path

      if tag_path == current_path then
        if vim.g.current_buf ~= current_index then
          vim.g.current_buf = tag and tag.path
        end

        if grapple_index ~= icon then
          vim.g[global] = icon
          require('lualine').refresh {}
        end
      else
        if grapple_index == icon then
          vim.g[global] = index
          require('lualine').refresh {}
        end
      end
    end

    vim.schedule(update_index)

    return string.format('%s', vim.g[global])
  end

  local exists = g.exists { scope = args.scope, index = args.index }

  return exists and get_index()
end

M.lualine.get_grapple_tag_path = function(args)
  local g = require 'grapple'

  local exists = g.exists { scope = args.scope, index = args.index }
  local tag = g.find { scope = args.scope, index = args.index }

  local path = exists and get_clean_path(tag.path) or ''
  return exists and string.format('%s', path) or ''
end

M.lualine.get_grapple_tag_color = function(args)
  local g = require 'grapple'

  return function()
    local current_buf = vim.g.current_buf
    local tag = g.find { scope = args.scope, index = args.index }
    local is_current = tag and current_buf == tag.path

    if is_current then
      return args.is_index and 'StatusLineTagBG' or 'StatusLineB'
    else
      return 'StatusLineNC'
    end
  end
end

M.lualine.unpack_grapple_statusline = function(args)
  local component = {}

  for index = 1, 10 do
    local tag_index = string.format('require("ui.navigation.config").lualine.get_grapple_tag_index{ index = %s, scope = %s  }', index, args.scope)
    local tag_index_color = M.lualine.get_grapple_tag_color
    table.insert(component, {
      tag_index,
      color = tag_index_color { scope = args.scope, index = index, is_index = true },
      padding = { left = 1, right = 1 },
    })

    local tag_path = string.format('require("ui.navigation.config").lualine.get_grapple_tag_path{ index = %s, scope = %s  }', index, args.scope)
    local tag_path_color = M.lualine.get_grapple_tag_color
    table.insert(component, {
      tag_path,
      color = tag_path_color { scope = args.scope, index = index },
      padding = { left = 0, right = 1 },
    })
  end

  return unpack(component)
end

M.grapple = {}

local count_slashes = function(path)
  local _, n = path:gsub '/'
  return n
end
local minify_directory = function(path)
  return string.format('%s/', string.sub(path, 1, 1))
end

local minify_path = function(args)
  -- local dont = args.no_minify
  local path = args.path
  local minified = string.gsub(path, '([%a-_]+)/', minify_directory(path))
  local count = #minified:gmatch '/'
  return path
end

M.grapple.build_lualine_component = function(args)
  local component = {}
  local g = require 'grapple'
  local tags_len = #g.tags { scope = args.scope }
  vim.g.grapple.tags.len = tags_len

  -- NO SE SI ESTO DEBERIA SER UN autocmd
  -- DEBERIA OCURRIR SOLAMENTE CUANDO SE AñADAN NUEVAS tags
  -- AL MENOS LA PARTE DE LOS paths
  vim.api.nvim_create_autocmd('FileType', {
    callback = function()
      local current_bfnr = vim.api.nvim_win_get_buf(0)
      local current_tag = g.find { scope = args.scope, buffer = current_bfnr }

      vim.g.grapple.current_tag = current_tag

      local paths = vim.g.grapple.paths or {}
      local tags = g.tags { scope = args.scope }
      if tags and #tags ~= vim.g.grapple.tags.len then
        vim.g.grapple.tags.len = #tags -- caching the number of tags

        for i, tag in ipairs(tags) do
          paths[i] = { { full_path = tag.path, no_minify = 1 } } -- don't minify the string fro m last slash to end
        end
      end

      for i, path in ipairs(paths) do
        path.clean_path = get_clean_path(path.full_path)
        local segments = path.clean_path:gmatch '([^/]+)'

        for j = #segments, 1, -1 do
          path.segments[j] = segments[#segments - j + 1]
        end
      end

      for i, path in ipairs(paths) do
      end

      -- ESTA VUELTA PA VER DONDE SE CORTA CA UNO

      require('lualine').refresh {}
    end,
  })

  local tags = require('grapple').tags { scope = args.scope }

  for index = 1, 10 do
    local tag_index = string.format('require("ui.navigation.config").lualine.get_grapple_tag_index{ index = %s, scope = %s  }', index, args.scope)
    local tag_index_color = M.lualine.get_grapple_tag_color
    table.insert(component, {
      tag_index,
      color = tag_index_color { scope = args.scope, index = index, is_index = true },
      padding = { left = 1, right = 1 },
    })

    local tag_path = string.format('require("ui.navigation.config").lualine.get_grapple_tag_path{ index = %s, scope = %s  }', index, args.scope)
    local tag_path_color = M.lualine.get_grapple_tag_color
    table.insert(component, {
      tag_path,
      color = tag_path_color { scope = args.scope, index = index },
      padding = { left = 0, right = 1 },
    })
  end
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
