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
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- load early-ish because we want highlighting available
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = { "javascript", "typescript", "tsx", "c", "cpp", "lua", "json", "html", "css" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = { "python" },
      },
      -- optional extras can be configured here if you like
      -- e.g. incremental_selection = { enable = true }, textobjects = { ... }
    },
    -- when using Lazy with opts, call setup in config
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "m-demare/hlargs.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    config = function(_, opts) require("hlargs").setup(opts) end,
  },

  {
    "p00f/nvim-ts-rainbow",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

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
  -- { "ayu-theme/ayu-vim" },
  { "Shatur/neovim-ayu" },

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
