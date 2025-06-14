return {
  'mfussenegger/nvim-lint',
  lazy = true,
  event = { 'BufWritePost' },
  cond = function()
    return not vim.g.vscode
  end,
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      markdown = {
        'markdownlint-cli2',
      },
      lua = { 'selene' },
      yaml = { 'yamllint' },
      ghactions = { 'yamllint', 'actionlint', 'zizmor' },
      python = { 'ruff', 'flake8' },
    }
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      group = vim.api.nvim_create_augroup('lint', { clear = true }),
      callback = function()
        lint.try_lint(nil, { ignore_errors = true })
      end,
    })
    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint(nil, { ignore_errors = true })
    end, { desc = 'Trigger linting for current file' })
  end,
}
