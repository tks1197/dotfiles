vim.filetype.add({
  pattern = {
    ['.*%.github/workflows/.*%.yml'] = 'ghactions',
    ['.*%.github/workflows/.*%.yaml'] = 'ghactions',
  },
})
