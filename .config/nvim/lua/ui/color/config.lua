local M = {}

-- This code is stolen directly from lualine github / theme auto section
-- Slight modifications to adapt it to neovim nightly (0.10 today)
-- And the style is totally inspired in tj's ui at date 09.04.2024

local function extract_highlight_colors(color_group, scope)
  local color = require('lualine.highlight').get_lualine_hl(color_group)
  if not color then
    if vim.fn.hlexists(color_group) == 0 then
      return nil
    end
    color = vim.api.nvim_get_hl(0, { name = color_group })
    if color.bg ~= nil then
      color.bg = string.format('#%06x', color.bg)
    end
    if color.fg ~= nil then
      color.fg = string.format('#%06x', color.fg)
    end
    if color.sp ~= nil then
      color.sp = string.format('#%06x', color.sp)
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

M.palette = {
  nor = extract_color_from_hllist('bg', { 'PmenuSel', 'PmenuThumb', 'TabLineSel' }, '#000000'),
  ins = extract_color_from_hllist('fg', { 'String', 'MoreMsg' }, '#000000'),
  rep = extract_color_from_hllist('fg', { 'Number', 'Type' }, '#000000'),
  vis = extract_color_from_hllist('fg', { 'Special', 'Boolean', 'Constant' }, '#000000'),
  com = extract_color_from_hllist('fg', { 'Identifier' }, '#000000'),
  fg_l = extract_color_from_hllist('fg', { 'Normal', 'StatusLine' }, '#000000'),
  fg_m = extract_color_from_hllist('bg', { 'Normal', 'StatusLine' }, '#000000'),
  bg_l = extract_color_from_hllist('bg', { 'CursorLine' }, '#000000'),
  bg_m = extract_color_from_hllist('bg', { 'Normal', 'StatusLineNC' }, '#000000'),
  bg_md = extract_color_from_hllist('bg', { 'TelescopeResultsNormal' }, '#000000'),
  bg_d = extract_color_from_hllist('bg', { 'StatusLine' }, '#000000'),
}

local c = M.palette

M.lualine = {}

M.lualine.theme = {
  normal = {
    a = { bg = c.bg_m, fg = c.fg_l },
    b = { bg = c.bg_d, fg = c.bg_l },
    c = { bg = c.bg_d, fg = c.fg_l },
  },
  insert = {
    a = { bg = c.bg_d, fg = c.fg_l },
    b = { bg = c.bg_d, fg = c.bg_l },
    c = { bg = c.bg_d, fg = c.fg_l },
  },
  replace = {
    a = { bg = c.bg_m, fg = c.rep },
    b = { bg = c.bg_d, fg = c.bg_l },
    c = { bg = c.bg_d, fg = c.fg_l },
  },
  visual = {
    a = { bg = c.bg_m, fg = c.vis },
    b = { bg = c.bg_d, fg = c.bg_l },
    c = { bg = c.bg_d, fg = c.fg_l },
  },
  command = {
    a = { bg = c.bg_m, fg = c.com },
    b = { bg = c.bg_d, fg = c.bg_l },
    c = { bg = c.bg_d, fg = c.fg_l },
  },
}

M.statusline = {}

M.statusline.set_highlight_groups = function()
  local p = M.palette
  local c = require('ui.color.config').lualine.theme

  vim.api.nvim_set_hl(0, 'StatusLineA', { fg = c.normal.b.bg, bg = c.normal.b.fg, bold = true }) -- position
  vim.api.nvim_set_hl(0, 'StatusLineAI', { fg = c.normal.b.bg, bg = c.normal.b.fg, bold = true }) -- position
  vim.api.nvim_set_hl(0, 'StatusLineB', { fg = p.fg_l, bg = p.bg_d }) -- buf
  vim.api.nvim_set_hl(0, 'StatusLineBI', { fg = p.fg_l, bg = p.bg_d, bold = true, italic = true }) -- buff
  vim.api.nvim_set_hl(0, 'StatusLineC', { fg = c.normal.c.fg, bg = c.normal.c.bg })
  vim.api.nvim_set_hl(0, 'StatusLineG', { bg = p.bg_l, bold = true })
  vim.api.nvim_set_hl(0, 'StatusLineTag', { fg = c.replace.a.fg, bold = true })
  vim.api.nvim_set_hl(0, 'StatusLineTagBG', { fg = c.replace.a.fg, bg = p.bg_d, bold = true })
  vim.api.nvim_set_hl(0, 'StatusLineDim', { fg = p.fg_m, bold = true })
  vim.api.nvim_set_hl(0, 'StatusLineError', { fg = c.replace.a.fg })
  vim.api.nvim_set_hl(0, 'StatusLineWarn', { fg = c.visual.a.fg })
  vim.api.nvim_set_hl(0, 'StatusLineInfo', { fg = c.insert.a.fg })
  vim.api.nvim_set_hl(0, 'StatusLineHint', { fg = c.command.a.fg })
end

M.incline = {}

M.incline.get_diagnostic_label = function(props)
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
      table.insert(label, { icon .. ' ' .. n .. ' ', group = 'StatusLine' .. severity })
    end
  end
  return label
end

return M
