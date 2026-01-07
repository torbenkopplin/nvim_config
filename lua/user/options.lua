local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = false
opt.wrap = false
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
-- opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
vim.o.mouse = ""
opt.startofline = false
vim.o.equalalways = true


-- Keeping it until I have decided if the plugin is significantly better.
-- -- Basic popup behaviour
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }
--
-- -- Enable LSP omnifunc for all LSP buffers
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--   end,
-- })
--
-- -- Auto-popup completion when typing
-- vim.api.nvim_create_autocmd("TextChangedI", {
--   callback = function()
--     local col = vim.fn.col(".")
--     if col <= 1 then return end
--
--     local line = vim.fn.getline(".")
--     local char = line:sub(col - 1, col - 1)
--
--     -- Only trigger on word characters
--     if not char:match("[%w_.]") then return end
--
--     -- Call omnifunc directly via Lua
--     -- First argument: findstart = 1 → get start column
--     local start = vim.lsp.omnifunc(1, "")
--     if not start or start < 0 then return end
--
--     -- Second call: findstart = 0 → get completion items
--     local items = vim.lsp.omnifunc(0, line:sub(start))
--     if not items or #items == 0 then return end
--
--     vim.fn.complete(start + 1, items)
--   end,
-- })
--

