return {
  {
    'folke/styler.nvim',
    config = function()
      local colorschemes = {}
      colorschemes['tokyonight'] = { 'lua' }
      colorschemes['gruvbox-material'] = { 'rust', 'help', 'lualine' }
      colorschemes['dracula'] = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json' }
      colorschemes['onedark'] = { 'html', 'htmldjango', 'css', 'scss', 'markdown' }

      local themes = require('config.color').setup_theme_table(colorschemes)

      require('styler').setup {
        themes = themes,
      }
    end,
  },
}
