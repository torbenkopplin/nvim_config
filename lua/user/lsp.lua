vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {
					'vim',
					'require'
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.lsp.config("eslint", {
  cmd = { vim.fn.getcwd() .. "/node_modules/.bin/eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
  root_markers = { ".eslintrc", ".eslintrc.json", ".eslintrc.js", "package.json" },
  settings = {
    eslint = {
      run = "onType",
      useESLintClass = false,
      codeActionOnSave = { enable = false, mode = "all" },
      format = false,
    },
  },
})
