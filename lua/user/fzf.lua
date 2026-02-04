
-- ~/.config/nvim/lua/user/fzf.lua
local fzf = require("fzf-lua")

-- (optional) default setup — adjust if you already call fzf.setup() elsewhere
fzf.setup({
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
    ["--history"] = vim.fn.stdpath("data") .. "/fzf-history",
  },
  preview = { default = "bat" },
})

local map_opts = { noremap = true, silent = true }

-- Normal mode mappings (like your old fzf.vim mappings)
vim.keymap.set("n", "<leader>p", function() fzf.files() end, vim.tbl_extend("force", map_opts, { desc = "FZF: Files" }))
vim.keymap.set("n", "<leader>f", function() fzf.live_grep() end, vim.tbl_extend("force", map_opts, { desc = "FZF: Live grep (rg)" }))
vim.keymap.set("n", "<leader>b", function() fzf.buffers() end, vim.tbl_extend("force", map_opts, { desc = "FZF: Buffers" }))
vim.keymap.set("n", "<leader>h", function() fzf.oldfiles() end, vim.tbl_extend("force", map_opts, { desc = "FZF: Recent files (oldfiles)" }))

-- Command history (like :History in fzf.vim)
vim.keymap.set("n", "<leader>H", function() fzf.cmd_history() end, vim.tbl_extend("force", map_opts, { desc = "FZF: Command history" }))

-- Visual-mode: grep for the selected text (press <leader>g in visual to search selection)
vim.keymap.set("n", "<leader>g", function()
  fzf.live_grep({ search = vim.fn.expand("<cword>") })
end, vim.tbl_extend("force", map_opts, { desc = "FZF: Live grep (visual selection)" }))

-- Multi-select: open multiple files in tabs (call with <leader>F)
vim.keymap.set("n", "<leader>F", function()
  fzf.files({
    multi = true,
    actions = {
      -- default Enter opens first, but ctrl-o here opens all selections in tabs
      ["ctrl-o"] = function(selected)
        if not selected or #selected == 0 then return end
        -- open first in current window, rest in tabs
        vim.cmd("edit " .. vim.fn.fnameescape(selected[1]))
        for i = 2, #selected do
          vim.cmd("tabnew " .. vim.fn.fnameescape(selected[i]))
        end
      end,
      -- keep default Enter behaviour for single select
      ["default"] = require("fzf-lua.actions").file_edit,
    },
  })
end, vim.tbl_extend("force", map_opts, { desc = "FZF: Files (multi -> ctrl-o opens all in tabs)" }))

-- Optional: LSP integration shortcuts using fzf-lua builtins
vim.keymap.set("n", "<leader>lr", function() fzf.lsp_references() end, vim.tbl_extend("force", map_opts, { desc = "FZF: LSP references" }))
vim.keymap.set("n", "<leader>ld", function() fzf.diagnostics() end, vim.tbl_extend("force", map_opts, { desc = "FZF: Diagnostics" }))
