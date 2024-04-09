return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        terminalColors = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
        theme = 'wave',
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        keywordStyle = { italic = true, bold = true },
        statementStyle = { bold = true },
        typeStyle = { bold = true },
        overrides = function(colors)
          local theme = colors.theme
          return {
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopeNormal = { bg = theme.ui.bg_p1 },
            TelescopeBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end,
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
          operators = true,
          folds = true,
        },
        strikethrough = true,
        inverse = true, -- invert background for search, diffs, statuslines and errors
      }
    end,
    opts = ...,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        enable = { terminal = true },
        styles = {
          bold = true,
          italic = true,
        },
      }
    end,
  },
  {
    'olimorris/onedarkpro.nvim',
    config = function()
      require('onedarkpro').setup {
        options = {},
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'night', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = 'day', -- The theme is used when the background is set to light
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = { bold = true },
        },
        on_colors = function(colors)
          -- colors.bg = '#181818'
        end,
      }
    end,
  },
}
