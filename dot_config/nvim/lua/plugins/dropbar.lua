return {
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    config = function()
      local wk = require 'which-key'
      wk.add {
        '<leader>db',
        function()
          require('dropbar.api').pick()
        end,
      }
    end,
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
    },
  },
}
