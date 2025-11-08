-- use your colorscheme first:
vim.cmd("colorscheme ayu")
vim.opt.termguicolors = true

-- make background transparent
local groups = {
  "Normal", "NormalNC", "SignColumn", "MsgArea", "LineNr", "CursorLineNr",
  "NonText", "FoldColumn", "StatusLine", "StatusLineNC", "TabLine",
  "TabLineFill", "TabLineSel", "VertSplit", "EndOfBuffer", "PMenu",
  "PMenuSel", "PMenuThumb", "WildMenu"
}

for _, group in ipairs(groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none" })
end

-- sometimes remove background of bufferline/plugins
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })


