require 'config.init'
require 'config.keymaps'
require 'config.color'

require('lazy').setup({
  -- Import plugins by domain
  -- NOTE: 2. UI keymaps have detailed explanation on plugin configuration
  { import = 'ui.keymaps' },
  { import = 'ui.color' },
  -- { import = 'ui.indent_line' },
  { import = 'ui.navigation' },
--  { import = 'ui.statusline' },
  { import = 'ui.git' },

  -- NOTE: 1. Comment has basic instructions on initializing plugins
  { import = 'code.comment' },
  { import = 'code.typing' },
  { import = 'code.formatting' },

  { import = 'code.treesitter' },
  { import = 'code.diagnostics' },

  { import = 'code.lsp' },
  { import = 'code.dap' },
  { import = 'code.cmp' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
