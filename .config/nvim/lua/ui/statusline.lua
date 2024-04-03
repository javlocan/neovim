return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        globalstatus = true,
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = ' ', right = ' ' },
        theme = 'gruvbox-material',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'buffers' },
        lualine_c = {},
        lualine_x = { 'diff' },
        lualine_y = { 'branch' },
        -- lualine_z = { 'progress' },
        lualine_z = {},
      },
    },
  },
  {
    'b0o/incline.nvim',
    event = 'VeryLazy',
    config = function()
      local function get_diagnostic_label(props, guibg)
        local icons = {
          Error = '',
          Warn = '',
          Info = '',
          Hint = '',
        }

        local label = {}
        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon .. ' ' .. n .. ' ', group = 'DiagnosticSign' .. severity, guibg = guibg })
          end
        end
        return label
      end

      require('incline').setup {
        window = {
          placement = {
            vertical = 'top',
            horizontal = 'right',
          },
          padding = 0, -- is only horizontal
          margin = { vertical = 2, horizontal = 0 },
        },
        -- Investigar esto de los highlight groups
        -- highlight = {
        --   groups = {
        --     InclineNormal = {
        --       default = false,
        --       group = 'StatusLine',
        --     },
        --   },
        -- },
        hide = {
          cursorline = true,
        },
        -- debounce_threshold = { falling = 500, rising = 250 },
        render = function(props)
          local c = require 'lualine.themes.gruvbox-material'
          c = {
            grey = c.normal.a.bg,
            black = c.normal.a.fg,
            lightgrey = c.normal.b.bg,
            white = c.normal.b.fg,
            darkgrey = c.normal.c.bg,
            -- c.fg = grey
          }

          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local gui_modified = vim.api.nvim_buf_get_option(props.buf, 'modified') and 'bold,italic' or 'None'
          local ft_icon, color = require('nvim-web-devicons').get_icon_color(filename)

          local helpers = require 'incline.helpers'

          local buffer = {
            -- ft_icon and { ' ', ft_icon, ' ', guibg = color, guifg = helpers.contrast_color(color) } or '',
            { '  ', filename, '  ', gui = gui_modified, guibg = c.lightgrey, guifg = c.white },
          }

          local diagnostics = get_diagnostic_label(props, c.darkgrey)
          if #diagnostics > 0 then
            table.insert(diagnostics, '')
          end

          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          local pos = string.format('%s:%s', col, row)
          local position = {
            string.format(' %5s ', pos),
            guibg = c.grey,
            guifg = c.black,
            gui = 'bold',
          }

          return {
            {
              ' ',
              diagnostics,
            },
            buffer,
            position,
          }
        end,
      }
    end,
  },
}
