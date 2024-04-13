return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          globalstatus = true,
          component_separators = { left = ' ', right = ' ' },
          section_separators = { left = ' ', right = ' ' },
          theme = require('ui.color.config').lualine.theme,
        },
        sections = {
          lualine_a = { {
            'mode',
            fmt = function(str)
              return string.format(' %s ', str)
            end,
          } },
          lualine_b = {}, --{ 'buffers' },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { 'diff', 'branch' },
          lualine_z = {}, -- probably unused because of aesthetics
        },
      }
    end,
  },
  {
    'b0o/incline.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lualine/lualine.nvim',
    },

    config = function()
      local incline = require('ui.color.config').incline
      local highlights = incline.get_highlights_from_lualine_theme()
      incline.set_incline_highlights(highlights)

      require('incline').setup {
        window = {
          placement = {
            vertical = 'top',
            horizontal = 'right',
          },
          padding = 0, -- is only horizontal
          margin = { vertical = 2, horizontal = 0 },
        },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local diagnostics = incline.get_diagnostic_label(props)
          local dynamic_space = (props.focused and #diagnostics > 0) and '' or ' '
          local diagnostics_indicator = #diagnostics > 0 and '  ' or ''
          diagnostics = props.focused and diagnostics or ''
          diagnostics = {
            diagnostics_indicator,
            diagnostics,
            group = 'InclineC',
          }
          local is_modified = vim.api.nvim_get_option_value('modified', { buf = props.buf })
          local italic = is_modified and 'I' or ''
          local dot = is_modified and '*' or ''

          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ':t')
          filename = filename == '' and '[No Name]' or filename
          filename = string.format('%s  %s%s  ', dynamic_space, filename, dot)
          -- local is_modified = vim.api.nvim_buf_get_option(props.buf, 'modified')
          local buffer_group = props.focused and 'InclineB' or 'InclineA'
          buffer_group = string.format('%s%s', buffer_group, italic)

          local buffer = {
            filename,
            group = buffer_group,
          }

          local row, col = unpack(vim.api.nvim_win_get_cursor(props.win))
          local pos = string.format('%s:%s', col, row)
          local position = { string.format(' %5s ', pos), group = 'InclineA' }

          return { diagnostics, buffer, position }
        end,
      }
    end,
  },
}
