-- https://github.com/OXY2DEV/markview.nvim
return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  enabled = true,
  dependencies = {
    'saghen/blink.cmp',
  },
  config = function()
    local presets = require('markview.presets')
    require('markview').setup({
      preview = {
        filetypes = {
          'md',
          'markdown',
          'codecompanion',
        },
        ignore_buftypes = {},
        condition = function(buffer)
          local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt

          if bt == 'nofile' and ft == 'codecompanion' then
            return true
          elseif bt == 'nofile' then
            return false
          else
            return true
          end
        end,
      },
      code_blocks = {
        style = 'simple',
      },
      markdown = {
        headings = presets.headings.glow,
        horizontal_rules = presets.horizontal_rules.dashed,
        table = presets.tables.rounded,
        list_items = {
          shift_width = function(buffer, item)
            --- Reduces the `indent` by 1 level.
            ---
            ---         indent                      1
            --- ------------------------- = 1 ÷ --------- = new_indent
            --- indent * (1 / new_indent)       new_indent
            ---
            local parent_indnet = math.max(1, item.indent - vim.bo[buffer].shiftwidth)

            return item.indent * (1 / (parent_indnet * 2))
          end,
          marker_minus = {
            add_padding = function(_, item)
              return item.indent > 1
            end,
          },
        },
      },
    })
  end,
}
