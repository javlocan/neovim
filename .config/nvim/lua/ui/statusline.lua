return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local opts = {
        options = {
          globalstatus = true,
          component_separators = { left = ' ', right = ' ' },
          section_separators = { left = ' ', right = ' ' },
          theme = require('config.color').lualine.theme,
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

      require('lualine').setup(opts)

      local incline = require('config.color').incline
      local highlights = incline.get_highlights_from_lualine_theme()

      vim.api.nvim_create_autocmd(
        {
          -- 'BufEnter',
          'FileType',
          'BufWinEnter',
          'WinNew',
        },
        -- 'Colorscheme',
        {
          callback = function()
            vim.schedule(function()
              incline.set_incline_highlights(highlights)
            end)
          end,
        }
      )
    end,
  },
  {
    'b0o/incline.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lualine/lualine.nvim',
    },

    config = function()
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
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          -- local is_modified = vim.api.nvim_buf_get_option(props.buf, 'modified')
          -- local gui_modified = is_modified and 'bold,italic' or 'None'

          -- local ft_icon, color = require('nvim-web-devicons').get_icon_color(filename)
          -- local helpers = require 'incline.helpers'

          local buffer = {
            -- ft_icon and { ' ', ft_icon, ' ', guibg = color, guifg = helpers.contrast_color(color) } or '',
            { '  ', filename, '  ' },
          }

          local incline = require('config.color').incline

          local diagnostics = incline.get_diagnostic_label(props)
          -- if #diagnostics > 0 then
          --   table.insert(diagnostics, 1, ' ')
          -- end

          local row, col = unpack(vim.api.nvim_win_get_cursor(props.win))
          local pos = string.format('%s:%s', col, row)
          local position = {
            string.format(' %5s ', pos),
            group = 'InclineA',
          }

          return {
            {
              group = 'InclineC',
              ' ',
              diagnostics,
            },
            {
              group = 'InclineB',
              buffer,
            },
            {
              position,
              group = 'InclineA',
            },
          }
        end,
      }
    end,
  },
}
