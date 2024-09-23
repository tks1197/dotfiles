-- markdown-toc.nvim
-- https://github.com/hedyhli/markdown-toc.nvim
-- markdownのTOCを生成するプラグイン。
return {
  'hedyhli/markdown-toc.nvim',
  ft = 'markdown', -- Lazy load on markdown filetype
  cmd = { 'Mtoc' }, -- Or, lazy load on "Mtoc" command
  opts = {
    -- Your configuration here (optional)
  },
}
