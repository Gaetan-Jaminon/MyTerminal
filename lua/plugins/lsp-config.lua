return {
  -- Mason: Package manager for LSP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  -- Mason-LSPConfig: Bridges Mason with nvim-lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup({
        -- Ensure required language servers are installed
        ensure_installed = { "lua_ls", "ansiblels", "yamlls", "omnisharp", "gopls" }  -- Add gopls for Go
      })
    end
  },
  -- LSPConfig: Configure individual language servers
  {
    'neovim/nvim-lspconfig',
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

      -- C#/.NET (Omnisharp) LSP configuration
      lspconfig.omnisharp.setup({
        cmd = { "omnisharp" },  -- Path to omnisharp executable
        root_dir = lspconfig.util.root_pattern(".sln", ".csproj", ".git"),  -- Detect project root
        settings = {
          omnisharp = {
            useModernNet = true,  -- Use modern .NET runtime
          },
        },
      })

      -- Go (gopls) LSP configuration
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            gofumpt = true,  -- Use gofumpt for formatting
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
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
      })

      -- General LSP key mappings
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})  -- Show documentation on hover
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})  -- Go to definition
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})  -- Find references
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})  -- Show code actions
      vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, {})  -- Shows parameter info while typing

    end
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

