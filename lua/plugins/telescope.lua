return {
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',  -- Specify the branch to use (here, the stable master branch)
    dependencies = {
      'nvim-lua/plenary.nvim'  -- Plenary is a utility library required by Telescope for many features
    },
    config = function()
      -- Import the built-in Telescope functionality (e.g., file search, live grep)
      local builtin = require("telescope.builtin")


      -- Setup Telescope and configure extensions (if any)
      require("telescope").setup({
        extensions = {
          -- Add the ui-select extension for better UI (dropdown theme)
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),  -- Use dropdown theme for selection
          },
        },
      })

      -- Key mappings for quick access to Telescope features
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})  -- Map Ctrl+p to search for files
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})  -- Map <leader>fg to live grep for text in files

      -- Load the ui-select extension for enhanced UI selection capabilities
      local telescope = require("telescope")
      telescope.load_extension("ui-select")
      telescope.load_extension('lazygit')
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",  -- Optional extension for a dropdown UI, useful for better UX
  },
}

