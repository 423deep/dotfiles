return {
  "mfussenegger/nvim-dap",
  opts = function(_, opts)
    vim.schedule(function()
      local ok, dap = pcall(require, "dap")
      if not ok then
        return
      end

      local function default_program_path()
        local basename = vim.fn.expand("%:t:r")
        local candidate = vim.fn.getcwd() .. "/build/" .. basename
        if vim.fn.executable(candidate) == 1 then
          return candidate
        end
        return nil
      end

      local function program_path()
        local default = default_program_path() or "/tmp/" .. vim.fn.expand("%:t:r")
        return vim.fn.input("Path to executable: ", default, "file")
      end

      local function apply(configs)
        if type(configs) ~= "table" then
          return
        end
        for _, config in ipairs(configs) do
          if config.request == "launch" then
            config.program = function()
              return default_program_path() or program_path()
            end
          end
        end
      end

      local ok_registry, registry = pcall(require, "mason-registry")
      if ok_registry and registry.has_package("codelldb") then
        local codelldb = registry.get_package("codelldb")
        local adapter = codelldb:get_install_path() .. "/extension/adapter/codelldb"
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = adapter,
            args = { "--port", "${port}" },
          },
        }
      end

      apply(dap.configurations.c)
      apply(dap.configurations.cpp)
    end)

    return opts
  end,
}
