-- skkeleton(SKK implements for Vim/Neovim with denops.vim )
-- https://github.com/vim-skk/skkeleton
return {
  'vim-skk/skkeleton',
  lazy = true,
  dependencies = {
    'vim-denops/denops.vim',
  },
  event = 'InsertEnter',
  config = function()
    -- see https://github.com/vim-skk/skkeleton/blob/main/doc/skkeleton.jax
    vim.fn['skkeleton#config']({
      globalDictionaries = {
        '~/.local/share/skk/SKK-JISYO-USER.euc',
        '~/.local/share/skk/SKK-JISYO.L',
        '~/.local/share/skk/SKK-JISYO.station',
        '~/.local/share/skk/SKK-JISYO.jinmei',
        '~/.local/share/skk/SKK-JISYO.propernoun',
        '~/.local/share/skk/SKK-JISYO.geo',
      },
      sources = { 'skk_dictionary', 'skk_server' },
      userDictionary = '~/.local/share/skkeleton/SKK-JISYO-USER.utf8',
      eggLikeNewline = true,
    })
    vim.fn['skkeleton#initialize']()
    vim.keymap.set({ 'i', 'c', 'l' }, '<C-i>', '<Plug>(skkeleton-toggle)')
  end,
}
