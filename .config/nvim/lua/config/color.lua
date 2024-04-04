local color = {}

color.setup_theme_table = function(colorschemes)
  local result = {}
  for cs, fts in pairs(colorschemes) do
    for _, ft in pairs(fts) do
      result[ft] = { colorscheme = cs }
      -- result[ft] = cs
    end
  end
  return result
end

color.set_theme = function(cs)
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
        color.set_theme(cs)
        break
      end
    end

    if not_in_list and colorscheme ~= default then
      color.set_theme(default)
    end
  end
end

color.incline = {}

color.incline.get_highlights_from_lualine_theme = function(c)
  local table = {}
  table.a = { name = 'InclineA', fg = c.normal.a.fg, bg = c.normal.a.bg, bold = true }
  table.b = { name = 'InclineB', fg = c.normal.b.fg, bg = c.normal.b.bg, bold = false }
  table.c = { name = 'InclineC', fg = c.normal.c.fg, bg = c.normal.c.bg, bold = false }
  table.e = { name = 'InclineError', fg = c.replace.a.bg, bg = c.normal.c.bg, bold = false }
  table.w = { name = 'InclineWarn', fg = c.visual.a.bg, bg = c.normal.c.bg, bold = false }
  table.i = { name = 'InclineInfo', fg = c.insert.a.bg, bg = c.normal.c.bg, bold = false }
  table.h = { name = 'InclineHint', fg = c.command.a.bg, bg = c.normal.c.bg, bold = false }
  return table
end

color.incline.set_incline_highlights = function(t)
  for _, hl in pairs(t) do
    vim.api.nvim_set_hl(0, hl.name, { fg = hl.fg, bg = hl.bg, bold = hl.bold })
  end
end

color.incline.get_diagnostic_label = function(props)
  local icons = {
    Error = '',
    Warn = '',
    Info = '',
    Hint = '',
  }

  local label = {}
  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
    if n > 0 then
      table.insert(label, { icon .. ' ' .. n .. ' ', group = 'Incline' .. severity })
    end
  end
  return label
end

return color
