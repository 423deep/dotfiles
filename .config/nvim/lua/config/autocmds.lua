-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local augroup = vim.api.nvim_create_augroup("johnny_config", { clear = true })

local function set_inlay_hints(enabled, bufnr)
  if vim.lsp.inlay_hint then
    if bufnr then
      vim.lsp.inlay_hint.enable(enabled, { bufnr = bufnr })
    else
      vim.lsp.inlay_hint.enable(enabled)
    end
    return
  end
  if vim.lsp.inlayhint then
    if bufnr then
      vim.lsp.inlayhint.enable(enabled, { bufnr = bufnr })
    else
      vim.lsp.inlayhint.enable(enabled)
    end
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
    vim.keymap.set("i", "{", "<CR>{<CR>}<Esc>O", { buffer = true, noremap = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "go",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    set_inlay_hints(false, args.buf)
    vim.defer_fn(function()
      set_inlay_hints(false, args.buf)
    end, 50)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  callback = function()
    set_inlay_hints(false)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = { "*.c", "*.h" },
  callback = function()
    if vim.fn.executable("clang-format") == 1 then
      local view = vim.fn.winsaveview()
      vim.cmd("silent keepjumps %!clang-format")
      vim.fn.winrestview(view)
    end
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    local win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      return
    end
    vim.api.nvim_win_set_height(win, 10)
  end,
})
