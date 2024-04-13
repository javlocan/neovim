require 'config'

require('lazy').setup({
  -- Import plugins by domain
  require 'ui.greeter',
  require 'ui.color', -- dir
  require 'ui.helpers',
  require 'ui.git',

  require 'ui.navigation', -- dir
  require 'ui.statusline',

  require 'code.treesitter',
  require 'code.edit', -- dir

  require 'code.diagnostics', -- dir
  require 'code.lsp', -- dir
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
