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

local data = vim.fn.stdpath("data")
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

vim.opt.undofile = true
vim.opt.undodir = data .. "/undo//"
vim.opt.directory = data .. "/swap//"
vim.opt.backupdir = data .. "/backup//"

vim.g.workspace_session_directory = data .. "/workspace/sessions"
vim.g.workspace_undodir = data .. "/undo//"
vim.g.workspace_autocreate = 1
vim.g.workspace_autosave = 0
