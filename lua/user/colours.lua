local colorscheme = 'noirblaze'
-- use your colorscheme first:
vim.cmd("colorscheme " .. colorscheme)
vim.opt.termguicolors = true

require('kanagawa').setup({
  mirage = false,
  terminal = true,
  overrides = {
    Normal = { bg = "None" },
    NormalFloat = { bg = "none" },
    ColorColumn = { bg = "None" },
    SignColumn = { bg = "None" },
    Folded = { bg = "None" },
    FoldColumn = { bg = "None" },
    CursorLine = { bg = "None" },
    CursorColumn = { bg = "None" },
    VertSplit = { bg = "None" },
  },
})

require('lualine').setup({
  options = {
    theme = 'ayu',
  },
})

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
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { link = "Hlargs" })

