# Zellij Integration Guide

Complete guide for using Zellij terminal multiplexer with your Neovim configuration, optimizing workflows for Claude Code and development tasks.

## Essential Zellij Shortcuts

### Pane Management
| Shortcut | Description | Neovim Integration |
|----------|-------------|-------------------|
| `Ctrl+h/j/k/l` | Navigate panes | Matches Neovim split navigation |
| `Ctrl+b` | New pane right | Horizontal split workflow |
| `Ctrl+v` | New pane down | Vertical split workflow |
| `Ctrl+d` | Close current pane | Clean workspace management |
| `Ctrl+m` | Toggle fullscreen | Focus mode for coding |

### Session Management
| Shortcut | Description | Use Case |
|----------|-------------|----------|
| `Ctrl+s` | Enter scroll mode | Review terminal output |
| `Ctrl+q` | Quit Zellij | End development session |
| `Ctrl+f` | Toggle floating pane | Temporary command execution |

## Integration Patterns

### 1. **Neovim + Claude Code Workflow**
```
┌─────────────────┬─────────────────┐
│     Neovim      │   Claude Code   │
│   (Primary)     │   (Assistant)   │
├─────────────────┼─────────────────┤
│   Terminal      │    Git/Build    │
│  (Commands)     │   (Operations)  │
└─────────────────┴─────────────────┘
```

**Workflow Steps**:
1. `Ctrl+h` - Focus Neovim for coding
2. `Ctrl+l` - Switch to Claude for assistance
3. `Ctrl+j` - Drop to terminal for commands
4. `Ctrl+k` - Access build/git operations

### 2. **Multi-Project Layout**
```
┌─────────┬─────────┬─────────┐
│ Proj A  │ Proj B  │ Shared  │
│ Neovim  │ Neovim  │ Tools   │
├─────────┼─────────┼─────────┤
│ Term A  │ Term B  │ Claude  │
└─────────┴─────────┴─────────┘
```

### 3. **Debug-Focused Layout**
```
┌──────────────────┬─────────┐
│     Neovim       │  Debug  │
│   (Main Code)    │ Output  │
├─────────┬────────┼─────────┤
│ Tests   │ Build  │ Claude  │
└─────────┴────────┴─────────┘
```

## User Interaction Possibilities

### 1. **Seamless Navigation Between Contexts**
```bash
# In Neovim: Working on Go code
func main() {
    // Cursor here
}

# Ctrl+l → Switch to Claude pane
# Ask Claude: "How do I add error handling here?"

# Ctrl+h → Back to Neovim
# Implement Claude's suggestion

# Ctrl+j → Terminal pane
go test ./...
```

### 2. **File Watching and Auto-Reload**
```bash
# Terminal pane: Watch for changes
watch -n 1 'go test ./...'

# Neovim pane: Code changes auto-detected
# Files reload automatically when Claude modifies them
```

### 3. **Copy-Paste Workflow**
```bash
# Neovim: Select code block
# Ctrl+c (copy to system clipboard)

# Ctrl+l → Claude pane
# Paste code for analysis

# Claude provides suggestions
# Copy Claude's response

# Ctrl+h → Back to Neovim
# Paste and integrate suggestions
```

## Developer Usability Features

### 1. **Optimized Keybinding Harmony**
| Context | Navigation | Benefit |
|---------|------------|---------|
| Neovim splits | `<C-h/j/k/l>` | Consistent muscle memory |
| Zellij panes | `Ctrl+h/j/k/l>` | Same navigation pattern |
| Terminal mode | `<Esc>` then nav | Quick context switching |

### 2. **Workspace Persistence**
```bash
# Save current layout
zellij action new-session --name "myproject"

# Restore layout later
zellij attach "myproject"
```

**Benefits**:
- **Session recovery**: Resume exactly where you left off
- **Project isolation**: Different layouts for different projects
- **Team sharing**: Share layout configurations

### 3. **Terminal Integration**
```bash
# From Neovim
:term                    # Opens terminal in current pane
<leader>cs              # Send current line to terminal

# From Zellij
Ctrl+j                  # Switch to dedicated terminal pane
```

### 4. **Claude Code Optimization**
- **Automatic reloading**: Files changed by Claude reload instantly
- **Conflict-free keys**: No overlap between Zellij and Neovim shortcuts
- **Shared clipboard**: Copy/paste works across all panes

## Advanced Zellij Features

### 1. **Custom Layouts**
```kdl
// ~/.config/zellij/layouts/dev.kdl
layout {
    pane split_direction="vertical" {
        pane {
            command "nvim"
            start_suspended true
        }
        pane split_direction="horizontal" {
            pane {
                command "zsh"
            }
            pane {
                command "claude-code"
                start_suspended true
            }
        }
    }
}
```

### 2. **Tab Management**
| Shortcut | Description | Development Use |
|----------|-------------|-----------------|
| `Ctrl+t` | New tab | Separate projects |
| `Ctrl+n` | Navigate tabs | Switch between contexts |
| `Alt+1-9` | Go to tab N | Quick project switching |

### 3. **Session Templates**
```bash
# Development template
zellij --layout dev

# Debug template  
zellij --layout debug

# Review template
zellij --layout review
```

## Workflow Optimizations

### 1. **Quick Project Setup**
```bash
# Single command to start development environment
dev-start() {
    cd "$1"
    zellij --layout dev
}

# Usage
dev-start ~/projects/myapp
```

### 2. **Context Switching**
```bash
# Save current context
zellij action dump-screen > context.txt

# Switch projects
zellij detach
zellij attach other-project

# Restore context when needed
cat context.txt
```

### 3. **Command Broadcasting**
```bash
# Send command to all panes
Ctrl+: (command mode)
> write-chars "git status"
> write-chars "Enter"
```

## Integration with External Tools

### 1. **Git Integration**
```bash
# Dedicated git pane
watch -n 5 'git status --porcelain'

# Git operations in separate pane
git add .
git commit -m "message"
git push
```

### 2. **Build Systems**
```bash
# Continuous build watching
Pane 1: nvim                    # Code editing
Pane 2: go run .               # Application running
Pane 3: go test -v ./...       # Test execution
Pane 4: claude-code            # AI assistance
```

### 3. **Monitoring and Logs**
```bash
# Multi-service development
Pane 1: nvim                   # Code
Pane 2: docker logs -f app     # App logs
Pane 3: docker logs -f db      # Database logs
Pane 4: htop                   # System monitoring
```

## Performance Features

### 1. **Resource Management**
- **Shared processes**: Multiple panes, single shell
- **Efficient rendering**: Minimal terminal overhead
- **Memory isolation**: Crashed panes don't affect others

### 2. **Network Efficiency**
- **Single SSH connection**: All panes share connection
- **Compressed data**: Reduced bandwidth usage
- **Local caching**: Faster response times

### 3. **Startup Optimization**
```bash
# Fast session restoration
zellij attach --create-if-not-exists myproject
```

## Troubleshooting

### Common Issues
| Issue | Cause | Solution |
|-------|-------|----------|
| Keys not working | Terminal TERM setting | Set `TERM=xterm-256color` |
| Panes not responding | Process hanging | `Ctrl+c` then `Ctrl+x` |
| Layout corrupted | Resize issues | `Ctrl+q` then reconnect |
| Copy/paste broken | Clipboard integration | Check terminal clipboard support |

### Debugging Steps
1. **Check Zellij status**: `zellij list-sessions`
2. **Verify configuration**: `zellij setup --check`
3. **Reset layout**: `Ctrl+q` and restart
4. **Clear cache**: `rm -rf ~/.cache/zellij`

## Best Practices

### 1. **Layout Design**
- **Consistent sizes**: Use percentage-based splits
- **Logical grouping**: Related tools in adjacent panes
- **Focus optimization**: Largest pane for primary task

### 2. **Session Management**
- **Descriptive names**: Use project names for sessions
- **Regular cleanup**: Close unused sessions
- **Backup configs**: Version control layout files

### 3. **Keyboard Efficiency**
- **Minimal key chords**: Prefer single modifiers
- **Consistent patterns**: Same keys for similar actions
- **Avoid conflicts**: Check for Neovim key overlaps

### 4. **Claude Code Integration**
- **Dedicated pane**: Always have Claude easily accessible
- **Shared workspace**: Same directory for all panes
- **Quick switching**: `Ctrl+h/l` between code and Claude

## Security Considerations

### 1. **Session Isolation**
- Different projects in separate sessions
- Clean environment variables between sessions
- Secure credential handling

### 2. **Network Security**
- SSH key-based authentication
- VPN for remote development
- Encrypted session data

This Zellij integration provides a seamless development environment that enhances productivity while maintaining security and performance.