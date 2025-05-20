return {
  cmd = { 'gh-actions-language-server', '--stdio' },
  -- the `root_markers` with `workspace_required` prevent attaching to every yaml file
  init_options = { sessionToken = '' },
  filetypes = { 'yaml.github' },
  root_markers = {
    '.github/workflows',
    '.forgejo/workflows',
    '.gitea/workflows',
  },
  workspace_required = true,
  capabilities = {
    workspace = {
      didChangeWorkspaceFolders = {
        dynamicRegistration = true,
      },
    },
  },
}
