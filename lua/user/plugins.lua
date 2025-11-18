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
        enable = false,
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

  -- fzf
  { "ibhagwan/fzf-lua", opts = {}},
  --
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

  { 'mason-org/mason.nvim', opts = {} },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = { 'vimls', 'ts_ls', 'lua_ls', },
    },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig'
    },
  },
  -- Autopairs for (), {}, [] and xml-tags
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
        priority = {
          [""] = 110,
        },
      }
    end,
  },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = { expand = function() end }, -- no snippets

        completion = { autocomplete = { cmp.TriggerEvent.TextChanged } },

        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
        },
      })

      -- Add LSP completion capability
      local caps = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("eslint", {
        cmd = { "node_modules/.bin/eslint-language-server", "--stdio" },
        capabilities = caps,
      })
    end,
  }


})
