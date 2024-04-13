return {
  {
    'folke/trouble.nvim',
    branch = 'dev', -- IMPORTANT!
    keys = {
      {
        '<leader>xd',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Tr[X]uble Open [D]iagnostics',
      },
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Tr[X]uble Open Buffer Diagnostics',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Tr[X]uble Open Symbols',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'Tr[X]uble Open LSP Definitions / references / ...',
      },
    },
    opts = {
      auto_close = true,
      restore = true,
      focus = true,
      keys = {
        ['<cr>'] = 'jump_close',
        ['o'] = 'jump',
      },

      win = { type = 'split', size = { height = 0.25 } },
      preview = {
        type = 'float',
        border = 'solid',
        position = { 0.05, 0.5 },
        size = { width = 0.5, height = 0.65 },
      },

      modes = {
        preview_float = {
          mode = 'diagnostics',
          preview = {
            type = 'float',
            relative = 'editor',
            border = 'rounded',
            title = 'Preview',
            title_pos = 'center',
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
        },
      },
    }, -- for default options, refer to the configuration section for custom setup.
  },
}
