-- plugins.lua
return {
  -- Lazy.nvim manager itself
  {
    "folke/lazy.nvim",
    version = "*",
  },

  -- Colorschemes
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000, -- load early
  },
  {
    "sainnhe/everforest",
    lazy = false,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
    },
    opts = {
      ensure_installed = { "javascript", "typescript", "jsdoc", "cpp", "lua", "html", "css", "json" },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = false },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    },
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

  -- LSP Configs
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = { 'vimls', 'ts_ls', 'lua_ls', 'eslint' }
        }
      },
      -- "jose-elias-alvarez/null-ls.nvim",
      -- "jose-elias-alvarez/typescript.nvim",
    },
    config = function()
      require("user.lsp")
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function() end
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  -- FZF integration
  {
    "ibhagwan/fzf-lua",
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      winopts = {
        height = 0.40,  -- bottom 40%
        width  = 1.0,
        row    = 1.0,   -- place at bottom
        col    = 0.5,
        border = "none",
      },
      fzf_opts = {
        ["--layout"] = "reverse",
        ["--info"]   = "inline",
      },
      preview = { default = "bat" },
      file_ignore_patterns = {
        "%.undodir",
      },
      files = {
        rg_opts = "--hidden --glob '!.git/*' --glob '**.undodir/**' --follow",
        fd_opts = "--exclude .undodir",
        file_icons = false, --true,
      },
      git = { files = { cmd = "git ls-files --exclude-standard" } },
    },
  },

  -- Closing tags, parentheses, and rainbow
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
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

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = false,
        theme = 'ayu',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- Vim workspace management
  {
    "thaerkh/vim-workspace",
  },

  --  Git
  { "tpope/vim-fugitive" },
}
