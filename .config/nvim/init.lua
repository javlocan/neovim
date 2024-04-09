require 'config.init'
require 'config.keymaps'

require('lazy').setup({
  -- Import plugins by domain
  require 'ui.keymaps',
  require 'ui.color', -- dir
  require 'ui.navigation', -- dir
  require 'ui.statusline',
  -- require 'ui.dressing',
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
