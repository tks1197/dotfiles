return {
  {
    'gbprod/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nord').setup({})
      vim.cmd.colorscheme('nord')
    end,
  },
  {
    'idr4n/github-monochrome.nvim',
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('github-monochrome-rosepine-dawn')
    end,
    opts = {},
  },
  {
    'EdenEast/nightfox.nvim',
    enabled = false,
    config = function()
      vim.cmd('colorscheme dawnfox')
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    enabled = false,
    config = function()
      vim.cmd('colorscheme rose-pine-dawn')
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'latte', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'auto',
          dark = 'auto',
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { 'italic' }, -- Change the style of comments
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
              ok = { 'italic' },
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
              ok = { 'underline' },
            },
            inlay_hints = {
              background = true,
            },
          },
          treesitter = true,
          treesitter_context = true,
          blink_cmp = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          fidget = true,
          flash = true,
          octo = true,
          snacks = true,
          copilot_vim = true,
          grug_far = true,
          diffview = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
