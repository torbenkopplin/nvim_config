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

keymap('n', '-', '/')

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

local function insert_blank_lines(dir)
  local count = vim.v.count1
  local pos = vim.api.nvim_win_get_cursor(0)
  local row = pos[1] - dir
  local col = pos[2]
  local newrowpos = pos[1] + ( count * dir )

  local lines = {}
  for _ = 1, count do
    table.insert(lines, "")
  end
  vim.api.nvim_buf_set_lines(0, row, row, false, lines)
  vim.api.nvim_win_set_cursor(0, {newrowpos, col})
end

keymap('n', '<C-j>', function()
  insert_blank_lines(0)
end, { desc = "Insert blank lines below."})

keymap('n', '<C->', function()
  insert_blank_lines(1)
end, { desc = "Insert blank lines above."})

-- Source - https://stackoverflow.com/a/77404322
-- Posted by Romain Vincent
-- Retrieved 2026-02-03, License - CC BY-SA 4.0
-- Use lowercase for global marks and uppercase for local marks.
local low = function(i) return string.char(97+i) end
local upp = function(i) return string.char(65+i) end

for i=0,25 do 
  vim.keymap.set("n", "m"..low(i), "m"..upp(i))
  vim.keymap.set("n", "m"..upp(i), "m"..low(i))
  vim.keymap.set("n", "'"..low(i), "'"..upp(i))
  vim.keymap.set("n", "'"..upp(i), "'"..low(i))
end
