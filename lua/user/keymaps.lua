vim.g.mapleader = ' '

local keymap = vim.keymap.set

keymap('n', '<leader>w', ':w<CR>')
keymap('n', '<leader>q', ':q<CR>')
keymap('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>')
keymap({'n', 'v'}, '<Space>', '<Nop>', { silent = true })
keymap('n', 'r', '<C-r>')
keymap('n', 'cä', ':cnext<CR>')
keymap('n', 'cå', ':cprevious<CR>')
keymap('n', 'ä', ']')
keymap('n', 'å', '[')
keymap('n', 'äd', ']d')
keymap('n', 'åd', '[d')


keymap('n', 'gd', vim.lsp.buf.definition)
keymap('n', 'gr', vim.lsp.buf.references)

keymap('n', '`', "'")
keymap('n', "'", '`')

keymap('n', 'j', 'gj')
keymap('n', 'gj', 'j')
keymap('n', 'k', 'gk')
keymap('n', 'gk', 'k')

vim.api.nvim_create_autocmd("FileType", {
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
