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

au("FileType", {
  pattern = "qf",
  callback = function()
    keymap("n", "o", function()
      local qf_win = vim.api.nvim_get_current_win()
      local ln = vim.api.nvim_win_get_cursor(0)[1]
      vim.cmd(ln .. "cc")
      vim.api.nvim_set_current_win(qf_win)
    end, { buffer = true, silent = true })

    keymap('n', '<CR>', '<CR>:cclose<CR>')
  end,
})
