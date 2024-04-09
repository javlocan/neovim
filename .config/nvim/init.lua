require 'config.init'
require 'config.keymaps'

require('lazy').setup({
  -- Import plugins by domain
  require 'ui.keymaps',
  require 'ui.color', -- dir
  require 'ui.navigation', -- dir
  require 'ui.statusline',
  require 'ui.git',
  require 'ui.greeter',

  require 'code.comment',
  require 'code.typing',
  require 'code.formatting',

  require 'code.treesitter',
  require 'code.diagnostics', -- dir

  require 'code.lsp', -- dir
  require 'code.dap',
  require 'code.cmp',

  {
    'Tummetott/reticle.nvim',
    opts = {},
  },
  {
    'sunjon/shade.nvim',
    config = function()
      require('shade').setup {
        overlay_opacity = 66,
        opacity_step = 6,
        keys = {
          toggle = '<C-w>d',
        },
      }
    end,
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
