local au = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set

au('VimResized', {
  group = vim.api.nvim_create_augroup('autoresize_windows', { clear = true}),
  callback = function()
    vim.schedule(function()
      vim.cmd('wincmd =')
    end)
  end,
})

au('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true}
    keymap('n', '<CR>', vim.lsp.buf.definition, opts)
  end
})

au("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    vim.opt.foldmethod = 'manual'
    vim.wo.foldmethod = 'manual'
    if ft == "javascript" then
      keymap('n', 'zxi', 'viBkzf')
      keymap('n', 'zxa', 'viBokzf')
    elseif ft == 'xml' then
      keymap('n', 'zxi', 'vitkojzf')
      keymap('n', 'zxa', 'vatzf')
    else
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldlevel = 99

      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  end
})
