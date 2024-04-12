return {
  {
    'stevearc/oil.nvim',
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = false,
        columns = {
          'icon',
          'permissions',
          'size',
          'mtime',
        },
        view_options = {
          show_hidden = true,
          natural_order = false,
        },
        float = {
          padding = 3,
          border = 'solid',
        },
      }
      vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'oil' },
        callback = function()
          vim.keymap.set('n', 'q', '<CMD>q<CR>', { desc = 'Open parent directory', buffer = true })
        end,
      })
    end,
  },
}
