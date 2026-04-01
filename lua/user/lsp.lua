local config = vim.lsp.config
local enable = vim.lsp.enable
config['lua_ls'] = {
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
}

config["eslint"] = {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
  root_markers = { "eslint.config.mjs", ".eslintrc", ".eslintrc.json", ".eslintrc.js", "package.json" },
  settings = {
    eslint = {
      run = "onType",
      useESLintClass = false,
      codeActionOnSave = { enable = false, mode = "all" },
      format = false,
    },
  },
}
config["clangd"] = {}

enable('lua_ls')
enable('eslint')
enable('clangd')
