return {
  {
    "rcarriga/nvim-dap-ui",
    opts = function(_, opts)
      opts.layouts = {
        {
          elements = {
            { id = "scopes", size = 0.35 },
            { id = "breakpoints", size = 0.2 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.2 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 12,
        },
      }
      return opts
    end,
  },
}
