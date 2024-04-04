return {
  {
    'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup {
        style = 'night',
        styles = {
          comments = { italic = true },
        },
      }
      -- vim.cmd 'colorscheme tokyonight'
    end,
  },
  {
    -- 'askfiy/visual_studio_code',
    'Mofiqul/dracula.nvim',
    priority = 100,
    -- opts = {},
  },
  -- {
  --   'Mofiqul/vscode.nvim',
  --   config = function()
  --     require('vscode').setup {
  --       italic_comments = true,
  --       underline_links = true,
  --     }
  --     -- vim.cmd 'colorscheme vscode'
  --   end,
  -- },
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_enable_bold = '1'
      vim.g.gruvbox_material_enable_italic = '1'
      vim.g.gruvbox_material_sign_column_background = 'grey'
      vim.g.gruvbox_material_ui_contrast = 'high'
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_diagnostic_line_highlight = '1'
      vim.g.gruvbox_material_diagnostic_text_highlight = '1'

      vim.cmd 'colorscheme gruvbox-material'
    end,
  },
  {
    'olimorris/onedarkpro.nvim',
    config = function()
      require('onedarkpro').setup {
        options = {
          -- transparency = true,
        },
      }
      -- local default = 'gruvbox-material'
      -- -- vim.cmd(string.format('colorscheme %s', default))
      --
      -- local colorscheme_augroup = vim.api.nvim_create_augroup('colorscheme', { clear = true })
      --
      -- local colorschemes = {}
      -- colorschemes['tokyonight'] = { 'lua' }
      -- colorschemes['gruvbox-material'] = { 'rust' }
      -- colorschemes['vscode'] = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json' }
      -- colorschemes['onedark'] = { 'html', 'htmldjango', 'css', 'scss' }
      --
      -- local c = require 'config.color'
      -- local colorschemes = c.setup_theme_table(colorschemes)
      --
      -- vim.api.nvim_create_autocmd({
      --   -- 'FileType',
      --   -- 'WinEnter',
      --   'BufEnter',
      -- }, {
      --   group = colorscheme_augroup,
      --   callback = function()
      --     c.check_and_set_theme(colorschemes, default)
      --   end,
      -- })
    end,
  },
}
