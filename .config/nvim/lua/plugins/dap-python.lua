return {
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local ok, registry = pcall(require, "mason-registry")
      if not ok or not registry.has_package("debugpy") then
        return
      end

      local debugpy_path = registry.get_package("debugpy"):get_install_path() .. "/venv/bin/python"

      local function python_path()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
          return venv .. "/bin/python"
        end

        local cwd = vim.fn.getcwd()
        local candidates = {
          cwd .. "/.venv/bin/python",
          cwd .. "/venv/bin/python",
        }

        for _, path in ipairs(candidates) do
          if vim.fn.executable(path) == 1 then
            return path
          end
        end

        local python3 = vim.fn.exepath("python3")
        if python3 ~= "" then
          return python3
        end

        return "python"
      end

      require("dap-python").setup(debugpy_path, { pythonPath = python_path })
      require("dap-python").test_runner = "pytest"
    end,
  },
}
