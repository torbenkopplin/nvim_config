local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  { "tpope/vim-fugitive" },

  -- UI & theme
  { "nvim-lualine/lualine.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- fzf
  { "ibhagwan/fzf-lua", opts = {}},

  -- LSP & completion
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
      "hrsh7th/nvim-cmp",
      dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "L3MON4D3/LuaSnip",
          "saadparwaiz1/cmp_luasnip",
      },
  },

  -- Colorscheme
  { "ayu-theme/ayu-vim" },

  { -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      -- See `:help lualine.txt`
      opts = {
          options = {
              icons_enabled = false,
              theme = 'ayu',
              component_separators = '|',
              section_separators = '',
          },
      },
  },

  {  'thaerkh/vim-workspace' },
})
