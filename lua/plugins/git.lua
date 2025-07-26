return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",                  -- Gitsigns plugin for showing Git signs in Neovim
    dependencies = { "nvim-lua/plenary.nvim" }, -- Dependency for various utilities used by Gitsigns
    config = function()
      require("gitsigns").setup({
        signs                        = {
          add          = { text = '┃' }, -- Symbol for added lines
          change       = { text = '┃' }, -- Symbol for changed lines
          delete       = { text = '▁' }, -- Symbol for deleted lines
          topdelete    = { text = '‾' }, -- Symbol for top-deleted lines
          changedelete = { text = '~' }, -- Symbol for changed and deleted lines
        },
        signcolumn                   = true, -- Show the sign column (left gutter)
        numhl                        = false, -- Disable number highlighting (can be toggled with `:Gitsigns toggle_numhl`)
        linehl                       = false, -- Disable line highlighting (can be toggled with `:Gitsigns toggle_linehl`)
        word_diff                    = false, -- Disable word diff highlighting (can be toggled with `:Gitsigns toggle_word_diff`)
        current_line_blame           = true, -- Show blame information for the current line
        current_line_blame_opts      = {
          virt_text = true, -- Use virtual text for blame info
          virt_text_pos = 'eol', -- Position blame info at the end of the line
          delay = 1000, -- Delay before showing blame info (in milliseconds)
          ignore_whitespace = false, -- Include whitespace changes in blame info
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>', -- Format for blame info
        sign_priority                = 6, -- Priority for displaying signs (higher number = higher priority)
        update_debounce              = 100, -- Debounce time for updates (in milliseconds)
        max_file_length              = 40000, -- Max file length for enabling Gitsigns (files longer than this will be ignored)
        preview_config               = {
          border = 'single', -- Border style for the preview window
          style = 'minimal', -- Window style
          relative = 'cursor', -- Position of the preview window relative to the cursor
          row = 0, -- Row position of the preview window
          col = 1, -- Column position of the preview window
        },
        on_attach                    = function(bufnr)
          -- Automatically refresh signs when files are changed
          vim.api.nvim_create_autocmd('BufWritePost', {
            buffer = bufnr,
            callback = function()
              require('gitsigns').refresh()
            end
          })
        end,
      })

      -- Setting highlights using Neovim's `vim.api.nvim_set_hl` to ensure proper appearance
      vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'DiffAdd' })       -- Highlight for added lines
      vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'DiffChange' }) -- Highlight for changed lines
      vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'DiffDelete' }) -- Highlight for deleted lines
    end,
  },
}
