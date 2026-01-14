vim.api.nvim_create_autocmd('VimResized', {
  group = vim.api.nvim_create_augroup('autoresize_windows', { clear = true}),
  callback = function()
    vim.schedule(function()
      vim.cmd('wincmd =')
    end)
  end,
})
