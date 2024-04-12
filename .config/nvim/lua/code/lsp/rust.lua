return {

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    config = function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.keymap.set('n', '<leader>a', function()
        vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
      end, { silent = true, buffer = bufnr })
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ['rust-analyzer'] = {
              checkOnSave = true,
              cargo = {
                features = 'all',
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true,
              },
              check = {
                enable = true,
                command = 'clippy',
                features = 'all',
              },
            },
          },
        },
      }
    end,
  },
}
