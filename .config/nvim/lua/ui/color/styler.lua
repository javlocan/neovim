return {
  {
    'folke/styler.nvim',
    config = function()
      local colorschemes = {}
      colorschemes['kanagawa-wave'] = { 'lua', 'bash', 'shell' }
      colorschemes['gruvbox'] = { 'rust', 'lualine' }
      colorschemes['onedark'] = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json' }
      colorschemes['rose-pine'] = { 'html', 'htmldjango', 'css', 'scss', 'markdown' }

      local themes = require('config.color').setup_theme_table(colorschemes)

      require('styler').setup {
        themes = themes,
      }
    end,
  },
}
