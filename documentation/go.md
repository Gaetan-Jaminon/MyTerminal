# Go Development in Neovim

This guide covers all Go-specific features and shortcuts available in your Neovim configuration.

## Key Shortcuts

### Navigation & Code Intelligence
| Shortcut | Description |
|----------|-------------|
| `K` | Show hover documentation for symbol under cursor |
| `<leader>gd` | Go to definition |
| `<leader>gr` | Find all references |
| `<leader>ca` | Show available code actions |
| `<C-k>` | Show signature help (in insert mode) |

### Formatting & Refactoring
| Shortcut | Description |
|----------|-------------|
| `<leader>gf` | Format current file |
| `:GoImports` | Organize imports (add missing, remove unused) |
| `:GoFmt` | Format with gofmt |
| `:GoFillStruct` | Fill struct literal with default values |
| `:GoAddTag` | Add json/xml tags to struct fields |
| `:GoRmTag` | Remove tags from struct fields |
| `:GoIfErr` | Generate if err != nil { return err } block |

### Testing & Coverage
| Shortcut | Description |
|----------|-------------|
| `:GoTest` | Run all tests in current package |
| `:GoTestFunc` | Run test for function under cursor |
| `:GoTestFile` | Run all tests in current file |
| `:GoCoverage` | Show test coverage (highlights uncovered code) |
| `:GoCoverageClear` | Clear coverage highlights |
| `:GoTestSum` | Run tests with gotestsum |

### Debugging
| Shortcut | Description |
|----------|-------------|
| `:GoDebug` | Start debugging session |
| `:GoDebugBreakpoint` | Toggle breakpoint |
| `:GoDebugContinue` | Continue execution |
| `:GoDebugNext` | Step over |
| `:GoDebugStep` | Step into |
| `:GoDebugStop` | Stop debugging |

### Code Generation
| Shortcut | Description |
|----------|-------------|
| `:GoGenerate` | Run go generate |
| `:GoImpl` | Generate method stubs for interface |
| `:GoMockGen` | Generate mocks |
| `:GoModTidy` | Run go mod tidy |
| `:GoModVendor` | Run go mod vendor |

## New User Experiences

### 1. **Intelligent Code Completion**
- **Context-aware suggestions**: gopls provides smart completions based on your code context
- **Auto-import packages**: Automatically adds import statements when you use a package
- **Method signatures**: Shows parameter hints as you type function calls
- **Snippet expansion**: Type `errn` + Tab for error handling, `fmtf` for fmt.Printf, etc.

### 2. **Real-time Error Detection**
- **Inline diagnostics**: See compilation errors as you type
- **Unused variable warnings**: Instantly highlights unused variables and imports
- **Type checking**: Catches type mismatches before compilation
- **Linting integration**: golangci-lint runs automatically showing style issues

### 3. **Smart Refactoring**
- **Rename symbols**: Rename variables/functions across entire project safely
- **Extract function/variable**: Select code and extract to function or variable
- **Fill structs**: Automatically populate struct literals with all fields
- **Generate tags**: Add JSON/XML tags to structs with proper naming conventions

### 4. **Enhanced Testing Workflow**
- **Run single tests**: Execute individual test functions from within the editor
- **Coverage visualization**: See which lines are covered by tests with color highlights
- **Test output**: View test results in floating windows
- **Debug tests**: Set breakpoints and step through test execution

### 5. **Code Navigation Superpowers**
- **Jump to definition**: Navigate to any symbol definition across packages
- **Find implementations**: Locate all implementations of an interface
- **Peek references**: See all usages of a symbol without leaving current file
- **Symbol outline**: View and jump to all functions/types in current file

### 6. **Automatic Code Formatting**
- **Format on save**: Code is automatically formatted with gofumpt on every save
- **Import organization**: Imports are grouped and sorted automatically
- **Consistent style**: Enforces standard Go formatting conventions

### 7. **Interactive Debugging**
- **Visual breakpoints**: Set/remove breakpoints with visual indicators
- **Variable inspection**: Hover to see variable values during debugging
- **Call stack navigation**: View and navigate the call stack
- **Step through code**: Step into, over, or out of functions

### 8. **Code Lenses**
- **Run/Debug buttons**: Clickable buttons above test functions
- **Package actions**: Tidy, vendor, and upgrade dependencies inline
- **Generate directives**: Execute go:generate directives with one click

### 9. **Type Information**
- **Inlay hints**: See parameter names and variable types inline
- **Type definitions**: Jump to type definitions and see documentation
- **Interface satisfaction**: Check if types implement interfaces

### 10. **Project-wide Operations**
- **Workspace symbols**: Search for any symbol across entire workspace
- **Global rename**: Rename symbols across multiple packages
- **Find all references**: See every usage of a symbol project-wide
- **Call hierarchy**: Visualize function call relationships

## Tips for Effective Go Development

1. **Use code actions**: Press `<leader>ca` frequently to see available refactorings
2. **Leverage snippets**: Type partial keywords and use Tab completion
3. **Run tests often**: Use `:GoTestFunc` to quickly test current function
4. **Check coverage**: Use `:GoCoverage` to ensure good test coverage
5. **Format on save**: Let auto-formatting handle code style
6. **Use inlay hints**: Enable to see parameter names and types inline
7. **Debug instead of print**: Use the debugger for complex issues
8. **Organize imports**: Let `:GoImports` manage your import statements

## Common Workflows

### Creating a New Go File
1. Create file with `.go` extension
2. Type `package` and let completion suggest package name
3. Start typing `func main` for executable or `func Test` for tests
4. Use snippets like `iferr` for error handling

### Writing Tests
1. Create `_test.go` file
2. Type `testf` snippet for test function template
3. Use `:GoTestFunc` to run individual test
4. Use `:GoCoverage` to check coverage

### Debugging an Issue
1. Set breakpoint with `:GoDebugBreakpoint`
2. Start debugger with `:GoDebug`
3. Step through code with navigation commands
4. Inspect variables in the debug panel

### Refactoring Code
1. Use `<leader>ca` to see available refactorings
2. Rename with LSP rename functionality
3. Extract functions/variables as needed
4. Use `:GoFillStruct` for struct literals