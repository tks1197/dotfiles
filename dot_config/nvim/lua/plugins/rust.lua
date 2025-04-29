return {
  -- https://github.com/mrcjkb/rustaceanvim
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    ft = { 'rust' },
    lazy = false, -- This plugin is already lazy
  },
  {
    -- crates.nvim(A neovim plugin that helps managing crates.io dependencies)
    -- https://github.com/saecki/crates.nvim
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
