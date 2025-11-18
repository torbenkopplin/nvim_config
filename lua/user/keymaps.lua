vim.g.mapleader = ' '

local keymap = vim.keymap.set

keymap('n', '<leader>w', ':w<CR>')
keymap('n', '<leader>q', ':q<CR>')
keymap('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>')
keymap({'n', 'v'}, '<Space>', '<Nop>', { silent = true })


keymap('n', 'gd', vim.lsp.buf.definition)
keymap('n', 'gr', vim.lsp.buf.references)
