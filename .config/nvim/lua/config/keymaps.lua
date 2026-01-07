-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local config = {
  compiler = "gcc",
  std = "c17",
  flags = "-Wall -Wextra -Werror -g",
  sanitizers = "-fsanitize=address,undefined",
  output_dir = "/tmp",
  split_size = 12,
  split_position = "botright",
}

local function compile_and_run()
  if vim.bo.filetype ~= "c" then
    vim.notify("Not a C file (filetype: " .. vim.bo.filetype .. ")", vim.log.levels.WARN)
    return
  end

  local ok, err = pcall(vim.cmd, "write")
  if not ok then
    vim.notify("Failed to save: " .. err, vim.log.levels.ERROR)
    return
  end

  local current_file = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t:r")
  local output = string.format("%s/%s", config.output_dir, filename)

  local compile_cmd = string.format(
    "%s %s %s %s %s -o %s",
    config.compiler,
    config.std and ("-std=" .. config.std) or "",
    config.flags,
    config.sanitizers,
    vim.fn.shellescape(current_file),
    vim.fn.shellescape(output)
  )

  local full_cmd = string.format(
    "%s && %s; read -p 'Press Enter to close...'",
    compile_cmd,
    vim.fn.shellescape(output)
  )

  vim.cmd(string.format("%s %dsplit", config.split_position, config.split_size))
  vim.cmd("term " .. full_cmd)

  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].bufhidden = "wipe"
  vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>:q<CR>", { buffer = buf, desc = "Close terminal" })
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>cx", compile_and_run, {
  desc = "Save, Compile & Run C file",
  silent = true,
})
