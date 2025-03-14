-- https://github.com/OXY2DEV/markview.nvim
return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  dependencies = {
    'saghen/blink.cmp',
  },
  config = function()
    local presets = require('markview.presets')
    require('markview').setup({
      markdown = {
        headings = presets.headings.glow,
        horizontal_rules = presets.horizontal_rules.dashed,
        table = presets.tables.rounded,
        list_items = {
          shift_width = 2,
        },
      },
    })
  end,
}
