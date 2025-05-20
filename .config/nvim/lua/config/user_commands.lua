-- User command: OrgSync
-- Sync orgfiles to dropbox using rclone
vim.api.nvim_create_user_command('OrgSync', function()
  -- Run the rclone sync command asynchronously
  local cmd = 'rclone sync $ZK_NOTEBOOK_DIR/orgfiles dropbox:org'
  vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('OrgSync: Sync completed successfully!', vim.log.levels.INFO)
      else
        vim.notify('OrgSync: Sync failed. Check :messages for details.', vim.log.levels.ERROR)
      end
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end, { desc = 'Sync orgfiles to dropbox using rclone' })
