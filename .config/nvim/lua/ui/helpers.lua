return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Tr[X]uble', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = 'Telescope [F]ind', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },
  {
    'Tummetott/reticle.nvim',
    opts = {},
  },
  -- {
  --   'sunjon/shade.nvim',
  --   config = function()
  --     require('shade').setup {
  --       overlay_opacity = 66,
  --       opacity_step = 6,
  --       keys = {
  --         toggle = '<C-w>d',
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   'simrat39/inlay-hints.nvim',
  --   config = function()
  --     require('inlay-hints').setup()
  --   end,
  -- },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      indent = {
        highlight = { 'Pmenu', 'Whitespace' },
        char = '',
      },
      whitespace = {
        highlight = { 'Pmenu', 'Whitespace' },
        remove_blankline_trail = false,
      },
      -- scope = { enabled = false },
      exclude = { filetypes = { 'dashboard', 'oil', 'help' } },
    },
  },
}
