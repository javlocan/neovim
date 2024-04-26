return {
  {
    'numToStr/Navigator.nvim',
    config = function()
      vim.keymap.set({ 'n', 't' }, '<C-h>', '<CMD>NavigatorLeft<CR>')
      vim.keymap.set({ 'n', 't' }, '<C-l>', '<CMD>NavigatorRight<CR>')
      vim.keymap.set({ 'n', 't' }, '<C-k>', '<CMD>NavigatorUp<CR>')
      vim.keymap.set({ 'n', 't' }, '<C-j>', '<CMD>NavigatorDown<CR>')

      local n = require 'Navigator'
      n.setup {}
    end,
  },
  {
    'willothy/wezterm.nvim',
    config = function()
      local w = require 'wezterm'
      -- w.switch_pane.toggle = function()
      --   local list = w.list_panes()
      --   local current = w.get_current_pane()
      --   local id = function()
      --     local a = list
      --         and function()
      --           for pane in pairs(list) do
      --             if current ~= pane then
      --               return pane
      --             end
      --           end
      --           return 0
      --         end
      --       or 0
      --     return a
      --   end
      --   w.switch_pane.id(id())
      -- end

      vim.keymap.set('n', '<C-w>%', function()
        w.split_pane.horizontal { percent = 25 }
      end)
      vim.keymap.set('n', '<C-w>"', function()
        w.split_pane.vertical { percent = 33 }
      end)
      -- vim.keymap.set('n', '<C-w>t', w.switch_pane.toggle)
    end,
  },
}
