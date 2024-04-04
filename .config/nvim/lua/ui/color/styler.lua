return {
  {
    'folke/styler.nvim',
    config = function()
      local colorschemes = {}
      colorschemes['rose-pine'] = { 'lua' }
      colorschemes['gruvbox'] = { 'rust', 'lualine' }
      colorschemes['onedark'] = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json' }
      colorschemes['kanagawa'] = { 'html', 'htmldjango', 'css', 'scss', 'markdown' }

      local themes = require('config.color').setup_theme_table(colorschemes)

      require('styler').setup {
        themes = themes,
      }
    end,
  },
}
