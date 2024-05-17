return {
  {
    'onsails/diaglist.nvim',
    config = function()
      local diaglist = require 'diaglist'
      diaglist.init {
        debug = false,
        debounce_ms = 140,
      }

      vim.keymap.set('n', '<leader>dw', function()
        diaglist.open_all_diagnostics()
      end, { desc = 'Open [D]iagnostics for [W]orkspace' })
      vim.keymap.set('n', '<leader>db', function()
        diaglist.open_buffer_diagnostics()
      end, { desc = 'Open [D]iagnostics for [B]uffer' })
    end,
  },
}
