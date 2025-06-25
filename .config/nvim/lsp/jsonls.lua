return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  single_file_support = true,
  init_options = {
    provideFormatter = true,
  },
  settings = {
    json = {
      validate = { enable = true },
    },
  },
}

