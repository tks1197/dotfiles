return {
  'mfussenegger/nvim-lint',
  event = { 'BufEnter', 'BufWritePost' },
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
    local augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    local _callback = function()
      lint.try_lint(nil, { ignore_errors = true })
    end
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = augroup,
      callback = _callback,
    })
    vim.keymap.set('n', '<leader>l', _callback, { desc = 'Trigger linting for current file' })
  end,
}
