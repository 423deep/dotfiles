return {
  "mfussenegger/nvim-dap",
  opts = function(_, opts)
    vim.schedule(function()
      local ok, dap = pcall(require, "dap")
      if not ok then
        return
      end

      local function program_path()
        local default = "/tmp/" .. vim.fn.expand("%:t:r")
        return vim.fn.input("Path to executable: ", default, "file")
      end

      local function apply(configs)
        if type(configs) ~= "table" then
          return
        end
        for _, config in ipairs(configs) do
          if config.request == "launch" then
            config.program = program_path
          end
        end
      end

      apply(dap.configurations.c)
      apply(dap.configurations.cpp)
    end)

    return opts
  end,
}
