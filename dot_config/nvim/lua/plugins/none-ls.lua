return {
  'nvimtools/none-ls.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'davidmh/cspell.nvim',
  },
  config = function()
    local async_formatting = function(bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()

      vim.lsp.buf_request(
        bufnr,
        'textDocument/formatting',
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
          if err then
            local err_msg = type(err) == 'string' and err or err.message
            -- you can modify the log message / level (or ignore it completely)
            vim.notify('formatting: ' .. err_msg, vim.log.levels.WARN)
            return
          end

          -- don't apply results if buffer is unloaded or has been modified
          if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, 'modified') then
            return
          end

          if res then
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or 'utf-16')
            vim.api.nvim_buf_call(bufnr, function()
              vim.cmd('silent noautocmd update')
            end)
          end
        end
      )
    end

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    local cspell = require('cspell')
    local cspell_config = {
      config_file_preferred_name = 'cspell.json',
      cspell_config_dirs = { '~/.config/cspell/' },
    }
    local null_ls = require('null-ls')
    null_ls.setup({
      debug = false,
      on_attach = function(client, bufnr)
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd('BufWritePost', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              async_formatting(bufnr)
            end,
          })
        end
      end,
      sources = {
        cspell.diagnostics.with({
          config = cspell_config,
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.INFO
          end,
        }),
        cspell.code_actions.with({ config = cspell_config }),
        -- null_ls.builtins.code_actions.textlint.with({
        --   -- TODO: After migrating PKM from obsidian, enable textlint to org files
        --   -- filetypes = { 'markdown', 'text', 'org' },
        --   extra_args = { '--config', vim.fn.expand('~/.config/textlint/.textlintrc.json') },
        -- }),
        -- null_ls.builtins.diagnostics.textlint.with({
        --   -- filetypes = { 'markdown', 'text', 'org' },
        --   extra_args = { '--config', vim.fn.expand('~/.config/textlint/.textlintrc.json') },
        -- }),
      },
    })
  end,
}
