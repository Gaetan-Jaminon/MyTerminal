# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Development
- **Reload configuration**: `:source %` or `:source $MYVIMRC`
- **Check for external file changes**: `:checktime` or `<leader>cr`
- **Install/update plugins**: Restart Neovim (plugins auto-install via Lazy.nvim)
- **LSP diagnostics**: `:LspInfo` to check language server status

### Plugin Management
- Plugins are managed by Lazy.nvim and auto-install on startup
- Plugin configurations are in `lua/plugins/` directory
- All plugins are installed locally in `plugins/` directory (not standard Lazy location)

## Architecture

### Core Structure
This is a modular Neovim configuration using Lua with Lazy.nvim as the plugin manager. The configuration follows a clear separation of concerns:

- **init.lua**: Entry point that bootstraps Lazy.nvim and loads settings/plugins
- **lua/settings/**: Core Neovim settings split into:
  - `options.lua`: General Neovim options
  - `keymaps.lua`: Global keybindings
  - `autocmds.lua`: Auto commands
  - `claude-integration.lua`: Special integration for Claude Code workflow
- **lua/plugins/**: Individual plugin configurations as separate files
- **plugins/**: Local plugin installation directory (non-standard location)

### Key Features
1. **LSP Configuration**: Mason manages LSP servers with configurations for Lua, Ansible, YAML, and C#/.NET
2. **File Management**: Supports both Neo-tree and NERDTree (transitioning)
3. **Git Integration**: Gitsigns and Lazygit for Git workflows
4. **Terminal**: Toggleterm for integrated terminal support
5. **Completion**: nvim-cmp with LSP, buffer, path, and snippet sources
6. **Claude Code Integration**: Auto-reload on external file changes, optimized for Zellij workflow

### Important Notes
- Uses custom plugin installation path at `~/.config/nvim/plugins/` instead of standard Lazy location
- Ansible development focus with ansible-ls and specific YAML configurations
- Auto-removes trailing whitespace on save
- Claude-specific keybindings under `<leader>c` prefix

## Plugins

### Core Plugin Manager
- **lazy.nvim** - Plugin manager

### File Management
- **neo-tree.nvim** - File explorer
- **nerdtree** - File explorer (transitioning to this)
- **telescope.nvim** - Fuzzy finder
- **plenary.nvim** - Lua utility library (dependency)

### LSP & Completion
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/DAP/linter/formatter installer
- **mason-lspconfig.nvim** - Bridge between Mason and lspconfig
- **nvim-cmp** - Autocompletion engine
- **cmp-nvim-lsp** - LSP source for nvim-cmp
- **cmp-buffer** - Buffer source for nvim-cmp
- **cmp-path** - Path source for nvim-cmp
- **LuaSnip** - Snippet engine
- **cmp_luasnip** - LuaSnip source for nvim-cmp

### Git Integration
- **gitsigns.nvim** - Git decorations
- **lazygit.nvim** - Lazygit integration

### UI & Appearance
- **catppuccin** - Color scheme
- **lualine.nvim** - Statusline
- **nvim-web-devicons** - File icons
- **nui.nvim** - UI component library

### Editor Enhancement
- **nvim-treesitter** - Syntax highlighting and code understanding
- **none-ls.nvim** - Use external tools as language servers
- **toggleterm.nvim** - Terminal integration

### Additional
- **ansible-doc.vim** - Ansible documentation integration
- **telescope-ui-select.nvim** - UI select replacement

### Go Development
- **go.nvim** - Comprehensive Go development plugin
- **nvim-dap** + **nvim-dap-go** - Go debugging support
- **neotest** + **neotest-go** - Go test runner integration
- **friendly-snippets** - Includes Go snippets

## Go Development Commands

### LSP Commands
- `K` - Show hover documentation
- `<leader>gd` - Go to definition
- `<leader>gr` - Find references
- `<leader>ca` - Code actions
- `<leader>gf` - Format code

### go.nvim Commands
- `:GoFmt` - Format current file
- `:GoImports` - Organize imports
- `:GoTest` - Run tests
- `:GoTestFunc` - Run test for current function
- `:GoCoverage` - Show test coverage
- `:GoAddTag` - Add struct tags
- `:GoFillStruct` - Fill struct with default values
- `:GoIfErr` - Generate if err != nil block
- `:GoDebug` - Start debugger

### Go Setup Requirements
- Install Go tools: `gofumpt`, `goimports`, `golangci-lint`, `delve`
- gopls will be auto-installed by Mason
- Treesitter parsers for go, gomod, gosum, gowork will auto-install