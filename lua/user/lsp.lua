-- ~/.config/nvim/lua/user/lsp.lua
local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
  vim.notify("nvim-cmp not found - LSP completion will be limited", vim.log.levels.WARN)
end

local has_luasnip, luasnip = pcall(require, "luasnip")
if not has_luasnip then
  vim.notify("LuaSnip not found - snippets disabled", vim.log.levels.WARN)
end

-- Setup cmp if present
if has_cmp then
  local cmp_mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  })
  cmp.setup({
    snippet = {
      expand = function(args)
        if has_luasnip then luasnip.lsp_expand(args.body) end
      end,
    },
    mapping = cmp_mapping,
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
    }),
  })
end

-- diagnostic signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- On attach keymaps (uses LspAttach autocmd - modern pattern)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
  end,
})

-- capabilities for nvim-cmp
local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {})
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

-- servers you want
vim.lsp.config = {
  lua_ls = {},
  tsserver = {}, -- or "tsserver" / "tsserver" via mason
  bashls = {},
  jsonls = {},
}

for name, config in pairs(vim.lsp.config) do
  config = vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- any per-client setup if needed
    end,
  }, config)
  vim.lsp.enable(config)
end
