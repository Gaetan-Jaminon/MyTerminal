-- 'nvim-treesitter/nvim-treesitter' is a Neovim plugin that enhances syntax highlighting, 
-- indentation, and other code-related features using the treesitter parsing library. 
-- Unlike traditional regex-based syntax highlighting, treesitter uses Abstract Syntax Trees (AST)
-- to provide more accurate and detailed understanding of your code structure.
-- It improves code navigation, highlighting, folding, and offers better context awareness.

return {
  "nvim-treesitter/nvim-treesitter",

  -- Automatically run `:TSUpdate` after the plugin is installed or updated to keep parsers up to date
  build = ":TSUpdate",

  config = function()
    -- Import the treesitter configuration module to set up its configurations
    local configs = require("nvim-treesitter.configs")

    -- Set up treesitter with the necessary configurations
    configs.setup({
      modules = {},
      ensure_installed = { "go", "gomod", "gosum", "gowork" },
      ignore_install = {},
      -- Automatically install missing parsers when opening files in unsupported languages
      auto_install = true,

      -- Install parsers asynchronously (in the background) without blocking Neovim
      sync_install = false,

      -- Enable treesitter-based syntax highlighting for supported languages
      highlight = {
        enable = true,
        -- Disable traditional regex-based syntax highlighting for performance improvement
        additional_vim_regex_highlighting = false,
      },

      -- Enable treesitter-based indentation for more accurate code indentation
      indent = {
        enable = true,
      },
    })
  end
}

