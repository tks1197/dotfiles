-- User command: OrgSync
-- Sync orgfiles to dropbox using rclone
vim.api.nvim_create_user_command('OrgSync', function()
  -- Run the rclone sync command asynchronously
  local cmd =
    "rclone bisync $ZK_NOTEBOOK_DIR/orgfiles/ dropbox:org --create-empty-src-dirs --compare size,modtime,checksum --slow-hash-sync-only --resilient -MvP --drive-skip-gdocs --fix-case --exclude 'projects/**'"
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

local function get_range_str(opts)
  if opts.range ~= 2 then
    return ''
  end
  if opts.line1 == opts.line2 then
    return '#L' .. opts.line1
  end
  return '#L' .. opts.line1 .. '-L' .. opts.line2
end
local function copy_path(opts, target)
  local expr = '%'
  if target == 'full path' then
    expr = '%:p'
  elseif target == 'file name' then
    expr = '%:t'
  end

  local path = vim.fn.expand(expr) .. get_range_str(opts)
  vim.fn.setreg('*', path)
  vim.notify('Copied ' .. target .. ': ' .. path)
end

vim.api.nvim_create_user_command('CopyFullPath', function(opts)
  copy_path(opts, 'full path')
end, { range = true, desc = 'Copy the full path of the current file to the clipboard' })

vim.api.nvim_create_user_command('CopyRelativePath', function(opts)
  copy_path(opts, 'relative path')
end, { range = true, desc = 'Copy the relative path of the current file to the clipboard' })

vim.api.nvim_create_user_command('CopyFileName', function(opts)
  copy_path(opts, 'file name')
end, { range = true, desc = 'Copy the file name of the current file to the clipboard' })
