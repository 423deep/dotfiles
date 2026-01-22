return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = opts.spec or {}
      table.insert(opts.spec, { "<leader>d", group = "+debug" })
      table.insert(opts.spec, { "<leader>T", group = "+test" })
      table.insert(opts.spec, { "<leader>t", group = "Neo-tree" })
      return opts
    end,
  },
}
