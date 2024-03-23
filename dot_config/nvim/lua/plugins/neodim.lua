-- 未使用の変数や関数の色合いを変更することのできるプラグイン
-- https://github.com/zbirenbaum/neodim
return {
  'zbirenbaum/neodim',
  event = 'LspAttach',
  config = function()
    require('neodim').setup {
      refresh_delay = 75,
      alpha = 0.5,
      blend_color = '#000000',
      hide = {
        underline = true,
        virtual_text = true,
        signs = true,
      },
      regex = {
        '[uU]nused',
        '[nN]ever [rR]ead',
        '[nN]ot [rR]ead',
      },
      priority = 128,
      disable = {},
    }
  end,
}
