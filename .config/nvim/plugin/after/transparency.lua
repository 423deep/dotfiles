-- transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
vim.api.nvim_set_hl(0, "Terminal", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "none" })

-- transparent background for neotree
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })

-- transparent background for nvim-tree
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

-- transparent notify background
vim.api.nvim_set_hl(0, "NotifyINFOBody", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORBody", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNBody", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACEBody", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyINFOTitle", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORTitle", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNTitle", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACETitle", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyINFOBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = "none" })

-- Darken UI bars to match tmux-style background while keeping editor transparent.
local bar_bg = "#282828"
local bar_fg = "#d4be98"
vim.api.nvim_set_hl(0, "StatusLine", { bg = bar_bg, fg = bar_fg })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = bar_bg, fg = bar_fg })
vim.api.nvim_set_hl(0, "TabLine", { bg = bar_bg, fg = bar_fg })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = bar_bg, fg = bar_fg })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = bar_bg, fg = bar_fg, bold = true })
vim.api.nvim_set_hl(0, "WinBar", { bg = bar_bg, fg = bar_fg })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = bar_bg, fg = bar_fg })
vim.api.nvim_set_hl(0, "BufferLineFill", { bg = bar_bg })
vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = bar_bg, fg = bar_fg })
vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = bar_bg, fg = bar_fg })
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = bar_bg, fg = bar_fg, bold = true })
vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = bar_bg, fg = bar_bg })
vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { bg = bar_bg, fg = bar_bg })
vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = bar_bg, fg = bar_bg })

-- Current line and selection highlight (avoid bright white bars).
local line_bg = "#2b2b2b"
local visual_bg = "#333333"
vim.api.nvim_set_hl(0, "CursorLine", { bg = line_bg })
vim.api.nvim_set_hl(0, "CursorLineNr", { link = "LineNr" })
vim.api.nvim_set_hl(0, "CursorLineSign", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = line_bg })
vim.api.nvim_set_hl(0, "Visual", { bg = visual_bg })
