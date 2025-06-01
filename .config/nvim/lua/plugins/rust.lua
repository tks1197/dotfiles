return {
  {
    'cordx56/rustowl',
    version = '*', -- Latest stable version
    build = 'cargo binstall rustowl',
    lazy = false, -- This plugin is already lazy
    config = function()
      require('rustowl').setup {
        auto_attach = false, -- Auto attach the RustOwl LSP client when opening a Rust file
        auto_enable = false, -- Enable RustOwl immediately when attaching the LSP client
        idle_time = 500, -- Time in milliseconds to hover with the cursor before triggering RustOwl
        client = {}, -- LSP client configuration that gets passed to `vim.lsp.start`
        highlight_style = 'undercurl', -- You can also use 'underline'
      }
    end,
  },
  -- https://github.com/mrcjkb/rustaceanvim
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    ft = { 'rust' },
    cond = function()
      return not vim.g.vscode
    end,
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- you can also put keymaps in here
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              checkOnSave = false,
            },
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
    -- opts = {
    --   tools = {
    --     enable_clippy = false,
    --   },
    -- },
    -- config = function(_, opts)
    --   require('rustaceanvim').setup(opts)
    -- end,
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
