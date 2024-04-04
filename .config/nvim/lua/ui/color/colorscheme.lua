return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        enable = { terminal = true },
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      }
    end,
  },
  {
    'olimorris/onedarkpro.nvim',
    config = function()
      require('onedarkpro').setup {
        options = {
          transparency = true,
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
  {
    'rebelot/kanagawa.nvim',
    priority = 2000,
    config = function()
      require('kanagawa').setup {
        terminalColors = true,
        transparent = true,
        theme = 'wave',
        background = { dark = 'dragon' },
        colors = { palette = { dragonBlack0 = '#181818' } },
      }
      vim.cmd 'colorscheme kanagawa'
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        transparent_mode = true,
      }
    end,
    opts = ...,
  },
}
