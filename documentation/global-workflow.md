# Global Workflow & Shortcuts

This document provides a comprehensive overview of global shortcuts, user interactions, and developer workflow possibilities in your Neovim configuration.

## Core Navigation & File Management

### Essential Shortcuts
| Shortcut | Command | Description |
|----------|---------|-------------|
| `<Space>` | Leader key | Prefix for most custom commands |
| `<C-n>` | Neo-tree | Open/reveal file explorer on the left |
| `<leader>e` | Neo-tree toggle | Toggle file explorer visibility |
| `<leader>ff` | Telescope | Find files in current directory |
| `<C-h/j/k/l>` | Window nav | Navigate between splits (Zellij compatible) |

### File Operations
| Shortcut | Description | Use Case |
|----------|-------------|----------|
| `<leader>cf` | Copy file/folder | Duplicate files with interactive prompt |
| `<leader>mf` | Move file/folder | Relocate files with interactive prompt |
| `<leader>w` | Remove trailing whitespace | Clean up code formatting |

## User Interaction Possibilities

### 1. **File Explorer Workflow**
```
<C-n> → Navigate with j/k → <Enter> to open → <leader>e to hide
```
- **Icons**: Full Unicode support for file types
- **Git integration**: See git status in file tree
- **Quick actions**: Create, delete, rename files directly

### 2. **Search & Navigation**
```
<leader>ff → Type filename → <Enter> to open
```
- **Fuzzy search**: Type partial names, get intelligent matches
- **Real-time preview**: See file contents while browsing
- **Recent files**: Quick access to recently opened files

### 3. **Multi-Window Workflow**
```
:split or :vsplit → <C-h/j/k/l> to navigate → Work across panes
```
- **Seamless navigation**: Mouse-free window switching
- **Zellij integration**: Works with terminal multiplexer
- **Consistent behavior**: Same keys work in Neovim and Zellij

## Developer Usability Features

### 1. **Intelligent Code Completion**
- **Context-aware**: Suggests based on current code context
- **Multi-source**: LSP, snippets, buffer text, file paths
- **Real-time**: No lag, instant suggestions
- **Documentation**: Hover information and signature help

### 2. **Real-time Error Detection**
- **As-you-type**: See errors immediately
- **Multiple languages**: Go, Lua, YAML, Ansible
- **Quick fixes**: `<leader>ca` for automated solutions
- **Navigation**: Jump between errors with LSP commands

### 3. **File Change Management**
```
External changes detected → Automatic reload → Notification shown
```
- **Claude integration**: Auto-reload when Claude modifies files
- **Smart detection**: Only reloads when actually changed
- **Backup safety**: No data loss during reloads

### 4. **Terminal Integration**
| Shortcut | Description | Developer Benefit |
|----------|-------------|-------------------|
| `<leader>cs` | Send line to terminal | Test code snippets instantly |
| `<Esc>` (in terminal) | Exit terminal mode | Quick navigation |
| `:term` | Open integrated terminal | Stay in editor context |

## Advanced Workflow Patterns

### 1. **Claude Code + Zellij Pattern**
```
Zellij pane 1: Neovim with Neo-tree
Zellij pane 2: Terminal for commands
Zellij pane 3: Claude Code session
```
**Benefits**:
- Seamless context switching
- Shared clipboard across panes
- Consistent keyboard navigation

### 2. **Project Development Flow**
```
1. <leader>ff → Find project files
2. <C-n> → Browse project structure
3. <leader>gd → Jump to definitions
4. <leader>gr → Find all references
5. <leader>ca → Apply code actions
```

### 3. **Multi-Language Development**
- **Go**: Full IDE experience with go.nvim
- **Ansible**: YAML validation and module documentation
- **Lua**: Native Neovim configuration editing
- **General**: Works with any LSP-supported language

## Customization Opportunities

### 1. **Keybinding Customization**
All keybindings are centralized in `lua/config/keymaps.lua`:
```lua
vim.keymap.set('n', '<your-key>', '<your-command>', { desc = 'Description' })
```

### 2. **Function Extensions**
Add custom functions in `lua/config/functions.lua`:
```lua
function M.your_function()
  -- Custom logic here
end
```

### 3. **Plugin Configuration**
Each plugin has its own file in `lua/plugins/`:
- Easy to modify settings
- Clear separation of concerns
- Quick enable/disable plugins

## Performance Features

### 1. **Lazy Loading**
- Plugins load only when needed
- Faster startup times
- Reduced memory usage

### 2. **Async Operations**
- Non-blocking file operations
- Background LSP processing
- Smooth user experience

### 3. **Optimized for SSH**
- Reduced visual effects over SSH
- Efficient terminal communication
- Zellij integration for multiplexing

## Troubleshooting Shortcuts

| Issue | Shortcut | Solution |
|-------|----------|----------|
| File not updating | `<leader>cr` | Reload changed files |
| Stuck terminal | `<Esc>` | Exit terminal mode |
| LSP not working | `:LspInfo` | Check LSP status |
| Plugin issues | `:Lazy` | Manage plugins |

## Quick Reference Card

### Most Used Shortcuts
```
<C-n>        - File explorer
<leader>ff   - Find files
<leader>gd   - Go to definition
<leader>ca   - Code actions
<leader>w    - Clean whitespace
<C-h/j/k/l>  - Navigate windows
```

### Emergency Commands
```
:checktime   - Reload files
:e!          - Force reload current file
:q!          - Quit without saving
:w           - Save current file
```

This configuration is designed for maximum productivity with minimal cognitive overhead, allowing you to focus on coding rather than remembering complex key combinations.