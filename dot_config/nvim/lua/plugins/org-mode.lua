return {
  {
    'nvim-orgmode/orgmode',
    lazy = true,
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      local agenda_homedir = vim.fn.expand('~/Documents/notebook/workspaces')
      require('orgmode').setup({
        org_agenda_files = agenda_homedir .. '**/*',
        org_default_notes_file = agenda_homedir .. '/today.org',
        win_split_mode = 'auto',
        win_border = 'rounded',
        org_startup_folded = 'overview',
        org_agenda_span = 'day',
        org_log_repeat = false,
        ui = {
          input = {
            use_vim_ui = true,
          },
        },
        org_capture_templates = {
          t = {
            description = 'Inbox TODO',
            template = '*** TODO %?\n',
            target = agenda_homedir .. '/today.org',
            headline = 'Inbox',
          },
          m = { description = 'Memo', template = '*** %<%H:%M:%S> %?', headline = 'Memo' },
          d = {
            description = 'Daily Journal',
            template = { '* %t', '** Inbox', '** Memo', '** Summary' },
          },
        },
      })
      -- list today's deadlines
      -- vim.api.nvim_create_autocmd('VimEnter', {
      --   pattern = '*',
      --   callback = function()
      --     local api = require('orgmode.api')
      --     local files = api.load()
      --     local result = {}
      --     for _, file in ipairs(files) do
      --       for _, headline in ipairs(file.headlines) do
      --         if headline.deadline and headline.deadline:is_today() then
      --           table.insert(result, headline.line)
      --         end
      --       end
      --     end
      --     vim.print(result)
      --   end
      -- })
      -- local function _create_org_file(input)
      --   local org_dir = vim.fn.expand('~/Documents/org/') -- The org directory
      --
      --   -- Validate the input
      --   if input == nil or input == '' then
      --     print('Invalid filename.')
      --     return
      --   end
      --
      --   -- Ensure the filename has the .org extension
      --   local filename = input:match('.*%.org$') and input or input .. '.org'
      --   local filepath = org_dir .. filename
      --
      --   -- Create the file and open it in a new tab
      --   vim.cmd('tabnew ' .. filepath)
      --   vim.notify('Created new org file in a new tab: ' .. filepath)
      -- end
      -- local function create_org_file()
      --   vim.ui.input({ prompt = 'Create new org file' }, _create_org_file)
      -- end
      -- vim.keymap.set(
      --   'n',
      --   '<leader>oc',
      --   create_org_file,
      --   { noremap = true, silent = true, desc = 'Create new org file' }
      -- )
    end,
  },
  {
    'akinsho/org-bullets.nvim',
    config = true,
    ft = 'org',
  },
  {
    '0xzhzh/fzf-org.nvim',
    lazy = false, -- lazy loading is handled internally
    dependencies = {
      'ibhagwan/fzf-lua',
      'nvim-orgmode/orgmode',
    },
    keys = {
      -- example keybindings
      {
        '<leader>og',
        function()
          require('fzf-org').orgmode()
        end,
        desc = 'org-browse',
      },
      {
        '<leader>of',
        function()
          require('fzf-org').files()
        end,
        desc = 'org-files',
      },
      {
        '<leader>or',
        function()
          require('fzf-org').refile_to_file()
        end,
        desc = 'org-refile',
      },
    },
    config = function()
      require('fzf-org').setup {} -- see below
    end,
  },
}
