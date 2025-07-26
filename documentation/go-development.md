# Go Development Guide

Comprehensive guide for Go development in your Neovim environment, covering shortcuts, workflows, and advanced features.

## Essential Go Shortcuts

### LSP Navigation
| Shortcut | Command | Description |
|----------|---------|-------------|
| `K` | Hover documentation | Show function/type documentation |
| `<leader>gd` | Go to definition | Jump to symbol definition |
| `<leader>gr` | Find references | Show all symbol references |
| `<leader>ca` | Code actions | Show available refactoring actions |
| `<leader>gf` | Format code | Format current file with gofumpt |
| `<C-k>` | Signature help | Show function parameters (insert mode) |

### go.nvim Commands
| Command | Shortcut | Description |
|---------|----------|-------------|
| `:GoFmt` | - | Format current file |
| `:GoImports` | - | Organize imports (add/remove) |
| `:GoTest` | - | Run all tests in package |
| `:GoTestFunc` | - | Run test for current function |
| `:GoCoverage` | - | Show test coverage highlights |
| `:GoAddTag` | - | Add struct tags (json, yaml, etc.) |
| `:GoFillStruct` | - | Fill struct with default values |
| `:GoIfErr` | - | Generate error handling block |

### Debugging
| Command | Description |
|---------|-------------|
| `:GoDebug` | Start debugging current package |
| `:GoDebugBreakpoint` | Toggle breakpoint at current line |
| `:GoDebugContinue` | Continue execution |
| `:GoDebugNext` | Step over (next line) |
| `:GoDebugStep` | Step into function |
| `:GoDebugStop` | Stop debugging session |

## User Interaction Possibilities

### 1. **Intelligent Code Completion**
```go
func main() {
    fmt.Pri|  // Type 'Pri' → Tab → Complete to 'Printf'
}
```
**Features**:
- **Function signatures**: See parameters while typing
- **Auto-imports**: Automatically add missing imports
- **Context-aware**: Suggests based on current scope
- **Documentation**: Inline docs for functions/types

### 2. **Error Detection & Quick Fixes**
```go
var unused string  // ← Highlighted as unused variable
```
**Capabilities**:
- **Real-time linting**: See errors as you type
- **Quick fixes**: `<leader>ca` to auto-fix issues
- **Import management**: Auto-add/remove imports
- **Code organization**: Suggest better patterns

### 3. **Test-Driven Development**
```go
func TestMyFunction(t *testing.T) {
    // Cursor here → :GoTestFunc → Run just this test
}
```
**Workflow**:
1. Write test function
2. `:GoTestFunc` to run specific test
3. `:GoCoverage` to see coverage
4. Implement function
5. `:GoTest` to run all tests

### 4. **Struct Tag Management**
```go
type User struct {
    Name  string  // Cursor here → :GoAddTag → json:"name"
    Email string  // → :GoAddTag → json:"email"
}
```

## Developer Usability Features

### 1. **Smart Refactoring**
| Action | How To | Result |
|--------|--------|---------|
| Rename symbol | `<leader>ca` → Rename | Updates all references |
| Extract function | Select code → `<leader>ca` | Creates new function |
| Add interface method | `<leader>ca` on interface | Generate method stub |
| Implement interface | `<leader>ca` on struct | Add missing methods |

### 2. **Code Generation**
```go
type User struct {
    Name string
    Age  int
}

var u User  // Cursor here → :GoFillStruct
// Becomes: u := User{Name: "", Age: 0}
```

### 3. **Error Handling Automation**
```go
result, err := someFunction()
// Cursor after this line → :GoIfErr
// Generates:
if err != nil {
    return err
}
```

### 4. **Import Intelligence**
- **Auto-import**: Type `fmt.Println` → import added automatically
- **Unused cleanup**: Removes unused imports on save
- **Grouping**: Groups standard, external, and local imports
- **Aliases**: Handles import aliases correctly

## Advanced Workflows

### 1. **Module Development Pattern**
```bash
# Terminal workflow integrated with Neovim
go mod init myproject     # Initialize module
<leader>ff → go.mod       # Open module file
:GoImports               # Organize dependencies
:GoTest                  # Run tests
```

### 2. **Microservice Development**
```go
// main.go
package main

func main() {
    // <leader>gd on http.ListenAndServe
    // → Jump to Go source code
    http.ListenAndServe(":8080", nil)
}
```

### 3. **Package Exploration**
```go
import "encoding/json"

// Hover over json.Marshal with 'K'
// → See full documentation
// → <leader>gd to see implementation
data, err := json.Marshal(obj)
```

### 4. **Testing Workflow**
```go
func TestUserValidation(t *testing.T) {
    tests := []struct {
        name string
        user User
        want bool
    }{
        // Table-driven tests
    }
    
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            // :GoTestFunc runs just this subtest
        })
    }
}
```

## Debugging Capabilities

### 1. **Visual Debugging**
- **Breakpoints**: Click or `:GoDebugBreakpoint` to set
- **Variable inspection**: Hover to see values
- **Stack trace**: Navigate call stack visually
- **Step execution**: Step through code line by line

### 2. **Integration with Tests**
```go
func TestComplexFunction(t *testing.T) {
    // Set breakpoint here
    result := ComplexFunction(input)
    // :GoDebug → debugs the test
}
```

### 3. **Remote Debugging**
- Connect to running Go applications
- Debug in production environments
- Attach to existing processes

## Performance Features

### 1. **Fast Compilation Feedback**
- **Real-time**: See build errors instantly
- **Incremental**: Only rebuild changed packages
- **Parallel**: Utilize multiple CPU cores

### 2. **Efficient Navigation**
- **Symbol cache**: Fast symbol lookup
- **Workspace awareness**: Understands module structure
- **Cross-package**: Navigate across different packages

### 3. **Memory Optimization**
- **Lazy loading**: LSP loads only when needed
- **Efficient parsing**: Optimized for large codebases
- **Resource management**: Automatic cleanup

## Go-Specific Snippets

### Common Patterns
| Trigger | Expansion |
|---------|-----------|
| `func` | Function template |
| `if` | If statement |
| `for` | For loop |
| `switch` | Switch statement |
| `struct` | Struct definition |
| `interface` | Interface definition |
| `err` | Error handling block |
| `test` | Test function template |

### Advanced Snippets
| Trigger | Description |
|---------|-------------|
| `http` | HTTP handler template |
| `json` | JSON marshaling example |
| `goroutine` | Goroutine with channel |
| `defer` | Defer statement with cleanup |
| `benchmark` | Benchmark test template |

## Integration with Build Tools

### 1. **Go Modules**
```go
// go.mod file support
go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    // Auto-completion for module names
)
```

### 2. **Build Tags**
```go
//go:build integration
// Build tag support and recognition
```

### 3. **Code Generation**
```go
//go:generate mockgen -source=user.go -destination=mocks/user.go
// Generate command integration
```

## Troubleshooting Go Development

| Issue | Solution | Command |
|-------|----------|---------|
| LSP not working | Check gopls installation | `:LspInfo` |
| Imports not working | Restart LSP | `:LspRestart` |
| Tests not running | Check test file naming | `:GoTest` |
| Debugging not starting | Check delve installation | `:GoDebug` |
| Formatting issues | Check gofumpt installation | `:GoFmt` |

## Best Practices

### 1. **Code Organization**
- Use `<leader>gd` to navigate large codebases
- Leverage `:GoImports` for clean import blocks
- Use `:GoAddTag` for consistent struct tags

### 2. **Testing Strategy**
- Write tests first, then use `:GoTestFunc`
- Use `:GoCoverage` to ensure good coverage
- Leverage table-driven tests with go.nvim

### 3. **Performance Optimization**
- Use LSP for real-time feedback
- Enable auto-formatting on save
- Leverage code lenses for quick actions

This Go development environment provides a complete IDE experience within Neovim, optimized for productivity and ease of use.