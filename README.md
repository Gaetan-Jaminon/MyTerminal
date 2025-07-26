# Modern Neovim Configuration

A comprehensive, modular Neovim configuration optimized for Go, Ansible, and Lua development with seamless Zellij terminal multiplexer integration.

## ✨ Features

- 🚀 **Lazy.nvim** plugin manager with optimized startup times
- 🔧 **LSP Integration** with Mason for automatic language server management
- 🌳 **Neo-tree** file explorer with Git integration and icons
- 🔍 **Telescope** fuzzy finder for files, symbols, and more
- 🎨 **Catppuccin** theme with consistent UI styling
- 🧪 **Go Development** complete IDE experience with go.nvim, testing, and debugging
- ⚙️  **Ansible Development** YAML validation, module documentation, and linting
- 📝 **Lua/Neovim** configuration development with intelligent completion
- 🖥️  **Zellij Integration** optimized keybindings and layouts
- 🤖 **Claude Code Integration** auto-reload and development workflow optimization

## 🛠️ Language Support

### Go Development
- **LSP**: gopls with advanced features
- **Testing**: Integrated test runner with coverage
- **Debugging**: Delve integration with visual debugging
- **Code Generation**: Struct tags, error handling, and more
- **Snippets**: Comprehensive Go snippets

### Ansible Development  
- **LSP**: ansible-ls with YAML validation
- **Documentation**: Built-in module documentation lookup
- **Linting**: Real-time ansible-lint integration
- **Intelligence**: Variable completion and cross-file references

### Lua/Neovim Development
- **LSP**: lua_ls with Neovim API completion
- **Interactive Development**: Live configuration reloading
- **Plugin Development**: Full tooling for creating Neovim plugins

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── CLAUDE.md                   # Project memory for Claude Code
├── README.md                   # This file
├── lazy-lock.json             # Plugin version lock file
├── lua/
│   ├── config/                # Core configuration
│   │   ├── options.lua        # Neovim settings
│   │   ├── keymaps.lua        # Key bindings
│   │   ├── autocmds.lua       # Auto commands
│   │   └── functions.lua      # Custom functions
│   ├── plugins/               # Plugin configurations
│   │   ├── lsp-config.lua     # LSP setup
│   │   ├── telescope.lua      # Fuzzy finder
│   │   ├── neo-tree.lua       # File explorer
│   │   ├── go.lua             # Go development tools
│   │   └── ...                # Other plugins
│   └── settings/
│       └── claude-integration.lua # Claude Code optimizations
├── documentation/             # Comprehensive guides
│   ├── global-workflow.md     # Essential shortcuts and workflows
│   ├── go-development.md      # Go development guide
│   ├── ansible-development.md # Ansible workflow guide
│   ├── lua-neovim-development.md # Lua/Neovim development
│   └── zellij-integration.md  # Terminal multiplexer integration
└── zellij/                    # Zellij configurations
    ├── config.kdl             # Main Zellij config
    └── layouts/               # Custom layouts
```

## 🚀 Quick Start

### Prerequisites

- **Neovim** 0.9+ 
- **Git** for plugin management
- **Node.js** for some LSP servers
- **Go** 1.21+ (for Go development)
- **Nerd Font** for icons (recommended: JetBrains Mono Nerd Font)

### Installation

1. **Backup existing configuration**:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```
   
   Plugins will automatically install on first launch.

4. **Install language servers** (automatic via Mason):
   - `:Mason` to open the installer
   - Language servers will auto-install based on file types

### Go Development Setup

1. **Install Go tools**:
   ```bash
   go install github.com/go-delve/delve/cmd/dlv@latest
   go install mvdan.cc/gofumpt@latest
   go install golang.org/x/tools/cmd/goimports@latest
   go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
   ```

2. **Ensure Go tools are in PATH**:
   ```bash
   export PATH=$PATH:$HOME/go/bin
   ```

## ⌨️ Essential Shortcuts

### Global Navigation
| Shortcut | Description |
|----------|-------------|
| `<Space>` | Leader key |
| `<C-n>` | Toggle file explorer |
| `<leader>ff` | Find files |
| `<C-h/j/k/l>` | Navigate splits |

### LSP Features
| Shortcut | Description |
|----------|-------------|
| `K` | Hover documentation |
| `<leader>gd` | Go to definition |
| `<leader>gr` | Find references |
| `<leader>ca` | Code actions |
| `<leader>gf` | Format code |

### Go Development
| Command | Description |
|---------|-------------|
| `:GoTest` | Run tests |
| `:GoDebug` | Start debugging |
| `:GoAddTag` | Add struct tags |
| `:GoIfErr` | Generate error handling |

## 🔧 Customization

### Adding Plugins

Add new plugins in `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({
      -- your configuration
    })
  end,
}
```

### Custom Keybindings

Add keybindings in `lua/config/keymaps.lua`:

```lua
vim.keymap.set('n', '<leader>x', '<cmd>YourCommand<CR>', { desc = 'Description' })
```

### Language Server Configuration

Modify LSP settings in `lua/plugins/lsp-config.lua`.

## 📖 Documentation

Comprehensive documentation is available in the `documentation/` directory:

- **[Global Workflow](documentation/global-workflow.md)** - Essential shortcuts and workflows
- **[Go Development](documentation/go-development.md)** - Complete Go development guide  
- **[Ansible Development](documentation/ansible-development.md)** - Ansible workflow and features
- **[Lua Development](documentation/lua-neovim-development.md)** - Lua and Neovim configuration development
- **[Zellij Integration](documentation/zellij-integration.md)** - Terminal multiplexer workflows

## 🌊 Zellij Integration

This configuration includes optimized Zellij layouts and keybindings for a seamless development experience:

- Conflict-free navigation between Neovim and Zellij
- Custom layouts for different development contexts
- Shared clipboard integration
- Optimized for Claude Code workflows

## 🤖 Claude Code Optimization

Special features for Claude Code development workflows:

- Automatic file reloading when Claude modifies files
- Optimized keybindings for rapid development cycles
- Memory system via `CLAUDE.md` for configuration context
- SSH-optimized settings for remote development

## 🎨 Theme

Uses the beautiful **Catppuccin** theme with the Mocha variant for a consistent, eye-friendly color scheme across all UI elements.

## 🐛 Troubleshooting

### Common Issues

1. **Icons not showing**: Install a Nerd Font and configure your terminal
2. **LSP not working**: Check `:LspInfo` and ensure language servers are installed
3. **Plugin errors**: Run `:Lazy update` to update plugins

### Getting Help

- Check the documentation in the `documentation/` directory
- Use `:help` for Neovim built-in help
- Run `:checkhealth` to validate your setup

## 🔄 Updates

To update the configuration:

```bash
cd ~/.config/nvim
git pull
nvim +Lazy update
```

## 📄 License

Feel free to use, modify, and share this configuration. No warranty provided.

## 🙏 Acknowledgments

This configuration is built on the excellent work of the Neovim community and utilizes many outstanding plugins. Special thanks to the maintainers of:

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - File explorer
- [go.nvim](https://github.com/ray-x/go.nvim) - Go development tools
- [catppuccin](https://github.com/catppuccin/nvim) - Beautiful theme

---

**Happy coding!** 🚀