return {
  {
    'cbochs/grapple.nvim',
    opts = {
      scope = 'git', -- also try out "git_branch"
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = 'Grapple',
    keys = {
      { 'mm', '<cmd>Grapple toggle scope=git<cr>', desc = 'Grapple toggle tag' },
      { '<leader>m', '<cmd>Grapple toggle_tags scope=git<cr>', desc = 'Grapple open tags window' },
      { 'm]', '<cmd>Grapple cycle_tags next scope=git<cr>', desc = 'Grapple cycle next tag' },
      { 'm[', '<cmd>Grapple cycle_tags prev scope=git<cr>', desc = 'Grapple cycle previous tag' },
      { 'mdd', '<cmd>Grapple reset scope=git<cr>', desc = 'Grapple cycle previous tag' },
    },
  },
}
