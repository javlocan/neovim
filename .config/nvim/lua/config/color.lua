local color = {}

color.setup_theme_table = function(colorschemes)
  local result = {}
  for cs, fts in pairs(colorschemes) do
    for _, ft in pairs(fts) do
      -- result[ft] = { colorscheme = cs }
      result[ft] = cs
    end
  end
  return result
end

local set_theme = function(cs)
  vim.schedule(function()
    local cmd = string.format('colorscheme %s', cs)
    vim.cmd(cmd)
  end)
end

color.check_and_set_theme = function(colorschemes, default)
  local colorscheme = function()
    return vim.cmd 'colorscheme'
  end
  local filetype = vim.bo.filetype

  local not_in_list = true

  if filetype ~= '' then
    for lang, cs in pairs(colorschemes) do
      if filetype == lang and colorscheme ~= cs then
        not_in_list = false
        set_theme(cs)
        break
      end
    end

    if not_in_list and colorscheme ~= default then
      set_theme(default)
    end
  end
end

return color
