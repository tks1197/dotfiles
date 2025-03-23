return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>j',
      function()
        local now = os.date('%Y-%m-%d-%A')
        local file = '~/Documents/notebook/journal/daily/' .. now .. '.md'
        Snacks.scratch({
          file = file,
          ft = 'markdown',
        })
      end,
      desc = 'Toggel Daily Journal',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>g',
      function()
        Snacks.lazygit()
      end,
      desc = 'Open Lazygit',
    },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    scratch = {
      enabled = true,
    },
    input = { enabled = true },
    scroll = { enabled = true },
    bigfile = { enabled = true },
    notifier = { enabled = false },
    bufdelete = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
      preset = {
        header = [[
     =================     ===============     ===============   ========  ========
     \\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
     ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
     || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
     ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
     || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
     ||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
     || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
     ||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
     ||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
     ||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
     ||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
     ||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
     ||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
     ||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
     ||.=='    _-'                                                     `' |  /==.||
     =='    _-'                        N E O V I M                         \/   `==
     \   _-'                                                                `-_   /
     `''                                                                      ``']],
      },
    },
    quickfile = { enabled = true },
    -- statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
