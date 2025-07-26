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
- Plugin configurations are organized in `lua/plugins/` subdirectories
- All plugins are installed locally in `plugins/` directory (not standard Lazy location)

## Architecture

### Core Structure
This is a modular Neovim configuration using Lua with Lazy.nvim as the plugin manager. The configuration follows a clean, organized structure:

- **init.lua**: Entry point that bootstraps Lazy.nvim and loads configurations
- **lua/config/**: Core Neovim configuration (NEW STRUCTURE)
  - `options.lua`: All Neovim options and settings
  - `keymaps.lua`: All keybindings in one place
  - `autocmds.lua`: Auto commands
  - `functions.lua`: Custom utility functions
- **lua/plugins/**: Plugin configurations organized by category
  - `core/`: Essential plugins (treesitter, telescope)
  - `lsp/`: LSP and completion related plugins
  - `ui/`: UI plugins (neo-tree, lualine, themes)
  - `tools/`: Development tools (go.nvim, git, ansible)
- **plugins/**: Local plugin installation directory

### Key Features
1. **LSP Configuration**: Mason manages LSP servers with configurations for Lua, Ansible, YAML, and Go
2. **File Management**: Neo-tree file explorer with icon support
3. **Git Integration**: Gitsigns and Lazygit for Git workflows
4. **Terminal**: Toggleterm for integrated terminal support
5. **Completion**: nvim-cmp with LSP, buffer, path, and snippet sources
6. **Claude Code Integration**: Auto-reload on external file changes, optimized for Zellij workflow

### Important Notes
- Uses custom plugin installation path at `~/.config/nvim/plugins/` instead of standard Lazy location
- Ansible development focus with ansible-ls and specific YAML configurations
- Auto-removes trailing whitespace on save
- Claude-specific keybindings under `<leader>c` prefix
- Zellij-optimized for seamless terminal multiplexer integration

## Key Shortcuts

### File Operations
| Shortcut | Description |
|----------|-------------|
| `<leader>ff` | Find files with Telescope |
| `<C-n>` | Open Neo-tree file explorer |
| `<leader>e` | Toggle Neo-tree |
| `<leader>cf` | Copy current file/folder |
| `<leader>mf` | Move current file/folder |

### Text Editing
| Shortcut | Description |
|----------|-------------|
| `<leader>w` | Remove trailing whitespace |

### Window Navigation (Zellij Compatible)
| Shortcut | Description |
|----------|-------------|
| `<C-h>` | Move to left split |
| `<C-j>` | Move to split below |
| `<C-k>` | Move to split above |
| `<C-l>` | Move to right split |

### Claude Code Integration
| Shortcut | Description |
|----------|-------------|
| `<leader>cr` | Reload changed files |
| `<leader>cR` | Force reload current file |
| `<leader>cs` | Send current line/selection to terminal |

### LSP (when active)
| Shortcut | Description |
|----------|-------------|
| `K` | Show hover documentation |
| `<leader>gd` | Go to definition |
| `<leader>gr` | Find references |
| `<leader>ca` | Show code actions |
| `<leader>gf` | Format code |

## Plugins

### Core Plugins
- **lazy.nvim** - Plugin manager
- **nvim-treesitter** - Syntax highlighting and code understanding
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

### UI Components
- **neo-tree.nvim** - Primary file explorer with icon support
- **catppuccin** - Color scheme
- **lualine.nvim** - Statusline
- **nvim-web-devicons** - File icons
- **nui.nvim** - UI component library

### Development Tools
- **go.nvim** - Comprehensive Go development plugin
- **nvim-dap** + **nvim-dap-go** - Go debugging support
- **neotest** + **neotest-go** - Go test runner integration
- **friendly-snippets** - Includes Go snippets
- **gitsigns.nvim** - Git decorations
- **lazygit.nvim** - Lazygit integration
- **none-ls.nvim** - Use external tools as language servers
- **toggleterm.nvim** - Terminal integration
- **ansible-doc.vim** - Ansible documentation integration
- **telescope-ui-select.nvim** - UI select replacement

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
- ✅ Go tools installed: `gofumpt`, `goimports`, `golangci-lint`, `delve` (in ~/go/bin)
- ✅ gopls will be auto-installed by Mason
- ✅ Treesitter parsers for go, gomod, gosum, gowork will auto-install
- ✅ PATH updated to include ~/go/bin

## Zellij Integration

### Zellij Shortcuts (Optimized for Neovim)
| Shortcut | Description |
|----------|-------------|
| `Ctrl+h/j/k/l` | Navigate panes (matches Neovim splits) |
| `Ctrl+b` | New pane right |
| `Ctrl+v` | New pane down |
| `Ctrl+d` | Close pane |
| `Ctrl+m/f` | Toggle fullscreen |
| `Ctrl+s` | Enter scroll mode |

### Notes
- `Ctrl+n` is reserved for Neo-tree in Neovim
- Zellij configuration optimized for keyboard-only workflow
- Seamless navigation between Neovim splits and Zellij panes

## Troubleshooting

### Common Issues
1. **Icons not showing**: Ensure you have a Nerd Font installed and configured in your terminal
2. **LSP not starting**: Check `:LspInfo` and ensure language servers are installed via Mason
3. **Zellij key conflicts**: Refer to the keybinding table above for conflict-free shortcuts
4. **Plugin errors**: Try `:Lazy update` to update all plugins

### Configuration Files
- Main config: `~/.config/nvim/init.lua`
- Zellij config: `~/.config/zellij/config.kdl`
- Plugin directory: `~/.config/nvim/plugins/`