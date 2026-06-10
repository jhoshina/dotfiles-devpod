return {
  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections.lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 1 } },
      }
      opts.sections.lualine_z = {
        { "location", padding = { left = 1, right = 1 } },
      }
    end,
  },
};
