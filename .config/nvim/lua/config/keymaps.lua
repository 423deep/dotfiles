-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local config = {
  compiler = "gcc",
  std = "c17",
  output_dir = "/tmp",
  split_size = 12,
  split_position = "botright",
}

-- Build profiles
local profiles = {
  strict = {
    flags = "-Wall -Wextra -Werror -g",
    sanitizers = "-fsanitize=address,undefined",
    libs = "",
  },
  cs50_strict = {
    flags = "-Wall -Wextra -Werror -g",
    sanitizers = "-fsanitize=address,undefined",
    libs = "-lcs50",
  },
  cs50_relaxed = {
    flags = "-Wall -Wextra -g",
    sanitizers = "",
    libs = "-lcs50",
  },
  relaxed = {
    flags = "-Wall -Wextra -g",
    sanitizers = "",
    libs = "",
  },
}

local function compile_and_run(profile)
  if vim.bo.filetype ~= "c" then
    vim.notify("Not a C file (filetype: " .. vim.bo.filetype .. ")", vim.log.levels.WARN)
    return
  end

  local ok, err = pcall(vim.cmd, "write")
  if not ok then
    vim.notify("Failed to save: " .. err, vim.log.levels.ERROR)
    return
  end

  local p = profiles[profile]
  if not p then
    vim.notify("Unknown build profile: " .. profile, vim.log.levels.ERROR)
    return
  end

  local current_file = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t:r")
  local output = string.format("%s/%s", config.output_dir, filename)

  local compile_cmd = string.format(
    "%s -std=%s %s %s %s %s -o %s",
    config.compiler,
    config.std,
    p.flags,
    p.sanitizers,
    vim.fn.shellescape(current_file),
    p.libs,
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
  vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>:q<CR>", { buffer = buf })
  vim.cmd("startinsert")
end

local function go_run()
  if vim.bo.filetype ~= "go" then
    vim.notify("Not a Go file (filetype: " .. vim.bo.filetype .. ")", vim.log.levels.WARN)
    return
  end

  local ok, err = pcall(vim.cmd, "write")
  if not ok then
    vim.notify("Failed to save: " .. err, vim.log.levels.ERROR)
    return
  end

  local current_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.fnamemodify(current_file, ":h")
  local cwd = current_dir
  local run_cmd = "go run ."

  local full_cmd = string.format(
    "cd %s && %s; read -p 'Press Enter to close...'",
    vim.fn.shellescape(cwd),
    run_cmd
  )

  vim.cmd(string.format("%s %dsplit", config.split_position, config.split_size))
  vim.cmd("term " .. full_cmd)

  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].bufhidden = "wipe"
  vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>:q<CR>", { buffer = buf })
  vim.cmd("startinsert")
end

-- Keymaps
vim.keymap.set("n", "<leader>cx", function()
  compile_and_run("strict")
end, { desc = "C: strict", silent = true })

vim.keymap.set("n", "<leader>cz", function()
  compile_and_run("cs50_strict")
end, { desc = "C: cs50 strict", silent = true })

vim.keymap.set("n", "<leader>cv", function()
  compile_and_run("cs50_relaxed")
end, { desc = "C: cs50 relaxed", silent = true })

vim.keymap.set("n", "<leader>cc", function()
  compile_and_run("relaxed")
end, { desc = "C: relaxed", silent = true })

vim.keymap.set("n", "<leader>cg", go_run, { desc = "Go: run", silent = true })
