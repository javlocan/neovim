require 'config'

require('lazy').setup({
  -- Import plugins by domain
  require 'ui.statusline', -- integration
  require 'ui.navigation', -- dir
  require 'ui.color', -- dir
  require 'ui.helpers', --dir

  require 'ui.greeter',

  require 'code.diagnostics', -- dir
  require 'code.lsp', -- dir
  require 'code.edit', -- dir

  require 'code.treesitter',
  require 'code.cmp',
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
