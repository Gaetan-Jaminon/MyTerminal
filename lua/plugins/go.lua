return {
  -- go.nvim: Feature-rich Go development plugin
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- LSP configuration
        lsp_cfg = false, -- false: use your own lspconfig, true: use go.nvim's lspconfig
        lsp_gofumpt = true, -- true: set default gofumpt in gopls format to true
        lsp_on_attach = nil, -- nil: use on_attach defined in go.nvim
        lsp_keymaps = false, -- set to false to disable gopls/lsp keymap

        -- Format on save (disabled for learning mode)
        fmt_on_save = {
          enabled = false,  -- Disabled to preserve learning errors
          pattern = { "*.go", "go.mod", "go.sum" },
        },
        fmt_experimental = false,

        -- Code lens
        lsp_codelens = true,

        -- Diagnostics
        diagnostic = {
          hdlr = true,
          underline = true,
          virtual_text = { space = 0, prefix = "■" },
          signs = true,
          update_in_insert = false,
        },

        -- Auto imports (disabled for learning mode)
        goimports = "", -- Disabled to preserve import errors for learning
        fillstruct = "gopls", -- can be nil (use fillstruct, slower) and gopls

        -- Tags
        tag_transform = false, -- can be transform option("snakecase", "camelcase", etc)
        tag_options = "json=omitempty",

        -- Test
        test_template = "", -- g:go_nvim_tests_template
        test_template_dir = "", -- default to nil if not set; g:go_nvim_tests_template_dir
        test_runner = "go", -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
        run_in_floaterm = false, -- set to true to run in a float terminal

        -- Misc
        comment_placeholder = "",
        icons = { breakpoint = "🧘", currentpos = "🏃" },
        verbose = false,
        log_path = vim.fn.stdpath("cache") .. "/go.nvim.log",
        lsp_document_formatting = true,
        lsp_inlay_hints = {
          enable = true,
          style = "inlay",
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_variable_name = true,
          parameter_hints_prefix = " ",
          show_parameter_hints = true,
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 6,
          highlight = "Comment",
        },
        gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
        dap_debug = true,
        dap_debug_keymap = true,
        dap_debug_gui = true,
        dap_debug_vt = true,
        dap_port = 38697,
        dap_timeout = 15,
        dap_retries = 20,
        build_tags = "tag1,tag2",
        textobjects = true,
        test_runner = "go",
        verbose_tests = true,
        run_in_floaterm = false,
      })

      -- Format on save autocmd (disabled for learning mode)
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*.go",
      --   callback = function()
      --     require("go.format").goimports()
      --   end,
      --   group = vim.api.nvim_create_augroup("GoFormat", {}),
      -- })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },

  -- DAP (Debug Adapter Protocol) for Go
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "delve" })
        end,
      },
    },
  },

  -- Go DAP adapter
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-go").setup()
    end,
  },

  -- Neotest adapter for Go
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          args = { "-tags=integration" },
        },
      },
    },
  },

  -- Friendly snippets (includes Go snippets)
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Go-specific keybindings (loaded after go.nvim)
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>t"] = { name = "+test" },
        ["<leader>tg"] = { name = "+go" },
      },
    },
  },
}