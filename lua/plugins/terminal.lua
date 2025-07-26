return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup{
        size = 20,
        open_mapping = [[<C-t>]],  -- Open terminal with Ctrl + T
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = true,
        direction = 'float',  -- Use floating window for terminal
        float_opts = {
          border = 'curved',  -- Border style for floating terminal
          winblend = 3,  -- Transparency for the floating terminal
        },
      }
    end
  },
}

