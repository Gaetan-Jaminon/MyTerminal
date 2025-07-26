return {
  -- LSP Configuration with Mason
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason: Package manager for LSP servers
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
          require("mason").setup()
        end,
      },
      -- Bridge between Mason and lspconfig
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "ansiblels", "yamlls", "gopls" },
            automatic_installation = true,
          })
        end,
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua LSP configuration
      lspconfig.lua_ls.setup({})

      -- Ansible LSP configuration (with YAML file support)
      lspconfig.ansiblels.setup({
        filetypes = { "yaml", "yml" },  -- Associate YAML/YML with Ansible
        settings = {
          ansible = {
            ansible = {
              path = "ansible",  -- Path to Ansible binary
              useFullyQualifiedCollectionNames = true  -- Enforce FQCN for modules
            },
            ansibleLint = {
              enabled = true,  -- Enable ansible-lint
              path = "ansible-lint"  -- Path to ansible-lint binary
            },
            executionEnvironment = {
              enabled = true  -- Use Ansible execution environment
            },
            python = {
              interpreterPath = "/usr/bin/python3"  -- Path to Python interpreter
            },
            completion = {
              provideRedirectModules = true,  -- Enable module redirection in completion
              provideModuleOptionAliases = true  -- Enable option alias completion
            }
          },
        },
      })

      -- YAML LSP configuration (disable key ordering rule)
      lspconfig.yamlls.setup({
        settings = {
          yaml = { keyOrdering = false },  -- Disable key ordering to support Ansible style
        },
      })

      -- Go (gopls) LSP configuration
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            gofumpt = false,  -- Disable auto-formatting to preserve learning errors
            codelenses = {
              gc_details = false,  -- Don't show gc details above functions
              generate = true,     -- Show generate comment above functions
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = false,  -- Disable auto-import to see import errors
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
        -- Disable automatic formatting on save
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      -- General LSP key mappings
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})  -- Show documentation on hover
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})  -- Go to definition
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})  -- Find references
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})  -- Show code actions
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})  -- Format code and organize imports
      vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, {})  -- Shows parameter info while typing
      
      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = true,  -- Show errors inline
        signs = true,         -- Show error signs in the gutter
        underline = true,     -- Underline errors
        update_in_insert = false,  -- Don't update diagnostics in insert mode
        severity_sort = true,  -- Sort by severity
      })
      
      -- Set up diagnostic keymaps
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic details' })
    end,
  },
  -- nvim-cmp: Autocompletion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",    -- Buffer source for nvim-cmp
      "hrsh7th/cmp-path",      -- Path source for nvim-cmp
      "L3MON4D3/LuaSnip",      -- Snippet engine for completion
      "saadparwaiz1/cmp_luasnip",  -- Snippet completion source for LuaSnip
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      -- Set up nvim-cmp for autocompletion
      cmp.setup({
        snippet = {
          expand = function(args)
            -- Use LuaSnip to expand snippets
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),  -- Scroll up in docs
          ['<C-f>'] = cmp.mapping.scroll_docs(4),   -- Scroll down in docs
          ['<C-Space>'] = cmp.mapping.complete(),   -- Trigger completion
          ['<C-e>'] = cmp.mapping.abort(),          -- Abort completion
          ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirm completion
          ['<Up>'] = cmp.mapping.select_prev_item(),  -- Navigate up in completion list
          ['<Down>'] = cmp.mapping.select_next_item(), -- Navigate down in completion list
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },  -- LSP-based autocompletion
          { name = 'luasnip' },   -- Snippet completion (LuaSnip)
          { name = 'buffer' },    -- Buffer-based autocompletion
          { name = 'path' },      -- File path autocompletion
        }),
      })
    end
  },
}