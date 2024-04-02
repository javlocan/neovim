local colors = {}

local BUILD_COLORSCHEME_TABLE = function(colorschemes)
  local result = {}
  for cs, fts in pairs(colorschemes) do
    for _, ft in pairs(fts) do
      result[ft] = cs
    end
  end
  return result
end

local SET_COLORSCHEME = function(cs)
  -- local animate = function()
  --   MiniColors.animate({ cs }, { transition_steps = 10, transition_duration = 120 })
  -- end
  -- vim.schedule(animate)
  vim.schedule(function()
    local cmd = string.format('colorscheme %s', cs)
    vim.cmd(cmd)
  end)
end


colors = {
  BUILD_COLORSCHEME_TABLE = BUILD_COLORSCHEME_TABLE,
  CHECK_AND_SET_COLORSCHEME = CHECK_AND_SET_COLORSCHEME,
}

_U = {
  colors = colors,
}

return _U
