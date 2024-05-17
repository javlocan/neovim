return {
  { import = 'ui.helpers.which-key' },
  { import = 'ui.helpers.indent-blankline' },
  { import = 'ui.helpers.gitsigns' },
  {
    'Tummetott/reticle.nvim',
    opts = {},
  },

  {
    'tris203/precognition.nvim',
    config = {
      -- startVisible = true,
      -- showBlankVirtLine = true,
      -- hints = {
      --     Caret = { text = "^", prio = 1 },
      --     Dollar = { text = "$", prio = 1 },
      --     w = { text = "w", prio = 10 },
      --     b = { text = "b", prio = 10 },
      --     e = { text = "e", prio = 10 },
      -- },
      -- gutterHints = {
      --     --prio is not currentlt used for gutter hints
      --     G = { text = "G", prio = 1 },
      --     gg = { text = "gg", prio = 1 },
      --     PrevParagraph = { text = "{", prio = 1 },
      --     NextParagraph = { text = "}", prio = 1 },
      -- },
    },
  }, -- {
  --   'sunjon/shade.nvim',
  --   config = function()
  --     require('shade').setup {
  --       overlay_opacity = 66,
  --       opacity_step = 6,
  --       keys = {
  --         toggle = '<C-w>d',
  --       },
  --     }
  --   end,
  -- },
}
