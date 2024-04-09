local color = {}

-- color.setup_theme_table = function(colorschemes)
--   local result = {}
--   for cs, fts in pairs(colorschemes) do
--     for _, ft in pairs(fts) do
--       result[ft] = { colorscheme = cs }
--       -- result[ft] = cs
--     end
--   end
--   return result
-- end
--
-- color.set_theme = function(cs)
--   vim.schedule(function()
--     local cmd = string.format('colorscheme %s', cs)
--     vim.cmd(cmd)
--   end)
-- end
--
-- color.check_and_set_theme = function(colorschemes, default)
--   local colorscheme = function()
--     return vim.cmd 'colorscheme'
--   end
--   local filetype = vim.bo.filetype
--
--   local not_in_list = true
--
--   if filetype ~= '' then
--     for lang, cs in pairs(colorschemes) do
--       if filetype == lang and colorscheme ~= cs then
--         not_in_list = false
--         color.set_theme(cs)
--         break
--       end
--     end
--
--     if not_in_list and colorscheme ~= default then
--       color.set_theme(default)
--     end
--   end
-- end

color.incline = {}

color.incline.get_highlights_from_lualine_theme = function()
  local table = {}
  local c = require('config.color').lualine.theme

  table.a = { name = 'InclineA', fg = c.normal.a.fg, bg = c.normal.b.fg, bold = true }
  table.b = { name = 'InclineB', fg = c.normal.a.fg, bg = c.normal.b.bg, bold = false }
  table.c = { name = 'InclineC', fg = c.normal.c.fg, bg = c.normal.c.bg, bold = false }
  table.e = { name = 'InclineError', fg = c.replace.a.fg, bg = c.normal.c.bg, bold = false }
  table.w = { name = 'InclineWarn', fg = c.visual.a.fg, bg = c.normal.c.bg, bold = false }
  table.i = { name = 'InclineInfo', fg = c.insert.a.fg, bg = c.normal.c.bg, bold = false }
  table.h = { name = 'InclineHint', fg = c.command.a.fg, bg = c.normal.c.bg, bold = false }
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

color.lualine = {}

-- This code is stolen directly from lualine github / theme auto section

local function extract_highlight_colors(color_group, scope)
  local color = require('lualine.highlight').get_lualine_hl(color_group)
  if not color then
    if vim.fn.hlexists(color_group) == 0 then
      return nil
    end

    color = vim.api.nvim_get_hl_by_name(color_group, true)
    if color.background ~= nil then
      color.bg = string.format('#%06x', color.background)
      color.background = nil
    end
    if color.foreground ~= nil then
      color.fg = string.format('#%06x', color.foreground)
      color.foreground = nil
    end
    if color.special ~= nil then
      color.sp = string.format('#%06x', color.special)
      color.special = nil
    end
  end
  if scope then
    return color[scope]
  end
  return color
end

local function extract_color_from_hllist(scope, syntaxlist, default)
  scope = type(scope) == 'string' and { scope } or scope
  for _, highlight_name in ipairs(syntaxlist) do
    if vim.fn.hlexists(highlight_name) ~= 0 then
      local color = extract_highlight_colors(highlight_name)
      for _, sc in ipairs(scope) do
        if color.reverse then
          if sc == 'bg' then
            sc = 'fg'
          else
            sc = 'bg'
          end
        end
        if color[sc] then
          return color[sc]
        end
      end
    end
  end
  return default
end

color.palette = {
  nor = extract_color_from_hllist('bg', { 'PmenuSel', 'PmenuThumb', 'TabLineSel' }, '#000000'),
  ins = extract_color_from_hllist('fg', { 'String', 'MoreMsg' }, '#000000'),
  rep = extract_color_from_hllist('fg', { 'Number', 'Type' }, '#000000'),
  vis = extract_color_from_hllist('fg', { 'Special', 'Boolean', 'Constant' }, '#000000'),
  com = extract_color_from_hllist('fg', { 'Identifier' }, '#000000'),
  fg_l = extract_color_from_hllist('fg', { 'Normal', 'StatusLine' }, '#000000'),
  bg_l = extract_color_from_hllist('bg', { 'CursorLine' }, '#000000'),
  bg_m = extract_color_from_hllist('bg', { 'StatusLine' }, '#000000'),
  bg_d = extract_color_from_hllist('bg', { 'Normal', 'StatusLineNC' }, '#000000'),
}

local c = color.palette
color.lualine.theme = {
  normal = {
    a = { bg = c.bg_d, fg = c.fg_l },
    b = { bg = c.bg_m, fg = c.bg_l },
    c = { bg = c.bg_m, fg = c.fg_l },
  },
  insert = {
    a = { bg = c.bg_d, fg = c.ins },
    b = { bg = c.bg_m, fg = c.bg_l },
    c = { bg = c.bg_m, fg = c.fg_l },
  },
  replace = {
    a = { bg = c.bg_d, fg = c.rep },
    b = { bg = c.bg_m, fg = c.bg_l },
    c = { bg = c.bg_m, fg = c.fg_l },
  },
  visual = {
    a = { bg = c.bg_d, fg = c.vis },
    b = { bg = c.bg_m, fg = c.bg_l },
    c = { bg = c.bg_m, fg = c.fg_l },
  },
  command = {
    a = { bg = c.bg_d, fg = c.com },
    b = { bg = c.bg_m, fg = c.bg_l },
    c = { bg = c.bg_m, fg = c.fg_l },
  },
}
return color
