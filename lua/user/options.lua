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
opt.laststatus = 3

vim.o.winborder = "rounded"

-- Workspace options
vim.opt.undofile = true
vim.g.workspace_autocreate = 1
vim.g.workspace_autosave = 0

local data = vim.fn.stdpath("data")
vim.opt.undodir = { data .. "/undo//" }
vim.opt.directory = { data .. "/swap//" }
vim.opt.backupdir = { data .. "/backup//" }
vim.g.workspace_session_directory = data .. "/workspace/sessions"
local dirs = {
  data .. "/undo",
  data .. "/swap",
  data .. "/backup",
  data .. "/workspace/sessions",
}

for _, dir in ipairs(dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

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

