# Lua & Neovim Configuration Development

Complete guide for developing Lua scripts and Neovim configurations, including plugin development and configuration customization.

## Essential Lua/Neovim Shortcuts

### LSP Navigation for Lua
| Shortcut | Description | Neovim Context |
|----------|-------------|----------------|
| `K` | Hover documentation | Show function/API documentation |
| `<leader>gd` | Go to definition | Jump to function definitions |
| `<leader>gr` | Find references | Find function usage |
| `<leader>ca` | Code actions | Lua-specific refactoring |
| `<leader>gf` | Format code | Stylua formatting |

### Configuration Testing
| Command | Description | Use Case |
|---------|-------------|----------|
| `:source %` | Reload current file | Test configuration changes |
| `:source $MYVIMRC` | Reload entire config | Apply all changes |
| `:lua =vim.inspect(...)` | Debug variables | Inspect Lua objects |
| `:checkhealth` | Check configuration | Validate setup |

### Plugin Development
| Command | Description | Plugin Dev Benefit |
|---------|-------------|-------------------|
| `:Lazy reload <plugin>` | Reload plugin | Test changes without restart |
| `:Lazy build <plugin>` | Rebuild plugin | Update after changes |
| `:messages` | Show messages | Debug plugin loading |

## User Interaction Possibilities

### 1. **Interactive Configuration Development**
```lua
-- config/keymaps.lua
vim.keymap.set('n', '<leader>test', function()
    print("Testing new keybinding")
    -- Cursor here → :source % → Test immediately
end, { desc = 'Test function' })
```

**Workflow**:
1. Edit configuration file
2. `:source %` to reload
3. Test functionality immediately
4. Iterate without restarting Neovim

### 2. **Plugin Configuration Experimentation**
```lua
-- plugins/example.lua
return {
    "plugin/name",
    config = function()
        require("plugin").setup({
            option = "value"  -- Change this
        })
    end
}
-- Save → :Lazy reload example → Test changes
```

### 3. **Custom Function Development**
```lua
-- config/functions.lua
function M.custom_search()
    local input = vim.fn.input("Search for: ")
    vim.cmd("Telescope grep_string default_text=" .. input)
end

-- Test with :lua require('config.functions').custom_search()
```

### 4. **API Exploration**
```lua
-- Interactive exploration
:lua =vim.fn.expand('%')           -- Current file path
:lua =vim.api.nvim_get_mode()      -- Current mode
:lua =vim.bo.filetype              -- Current filetype
:lua =vim.opt.number:get()         -- Get option value
```

## Developer Usability Features

### 1. **Intelligent Completion**
```lua
vim.api.nvim_|  -- Auto-complete shows all nvim_ functions
vim.keymap.|    -- Shows set, del, etc.
vim.opt.|       -- Shows all available options
```

**Features**:
- **API awareness**: Complete Neovim API functions
- **Context-sensitive**: Suggests relevant options
- **Documentation**: Inline help for functions
- **Type hints**: Parameter information

### 2. **Real-time Validation**
```lua
vim.keymap.set('n', '<leader>bad')  -- Missing required parameter
-- ↑ Highlighted as error immediately
```

### 3. **Configuration Structure Navigation**
```lua
-- init.lua
require('config.options')      -- <leader>gd jumps to file
require('config.keymaps')      -- Navigate config structure
require('plugins.lsp-config')  -- Quick access to plugin configs
```

### 4. **Plugin Development Support**
```lua
-- Custom plugin structure
local M = {}

function M.setup(opts)
    opts = opts or {}
    -- Plugin setup code
    -- Full LSP support for development
end

return M
```

## Advanced Lua Development Workflows

### 1. **Configuration Modularization**
```lua
-- config/options.lua
local options = {
    number = true,
    relativenumber = true,
    expandtab = true,
}

for option, value in pairs(options) do
    vim.opt[option] = value  -- <leader>gd on 'option' shows definition
end
```

### 2. **Custom Command Creation**
```lua
-- Create custom commands
vim.api.nvim_create_user_command('ConfigReload', function()
    vim.cmd('source $MYVIMRC')
    print('Configuration reloaded!')
end, { desc = 'Reload Neovim configuration' })
```

### 3. **Autocommand Development**
```lua
-- Smart autocmd creation
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.lua',
    callback = function()
        vim.lsp.buf.format()  -- Auto-format Lua files
    end,
    desc = 'Format Lua files on save'
})
```

### 4. **Plugin Integration Patterns**
```lua
-- Safe plugin loading
local ok, plugin = pcall(require, 'plugin-name')
if not ok then
    vim.notify('Plugin not found: plugin-name', vim.log.levels.WARN)
    return
end

plugin.setup({
    -- Configuration
})
```

## Neovim API Mastery

### 1. **Buffer Operations**
```lua
-- Get current buffer content
local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

-- Modify buffer
vim.api.nvim_buf_set_lines(0, 0, 1, false, {'New first line'})

-- Buffer-local options
vim.api.nvim_buf_set_option(0, 'filetype', 'lua')
```

### 2. **Window Management**
```lua
-- Create floating window
local buf = vim.api.nvim_create_buf(false, true)
local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = 50,
    height = 10,
    col = 10,
    row = 10,
    style = 'minimal',
    border = 'rounded'
})
```

### 3. **Keymap Programming**
```lua
-- Dynamic keymaps
local function create_git_keymaps()
    local git_maps = {
        ['<leader>gs'] = ':Git status<CR>',
        ['<leader>gc'] = ':Git commit<CR>',
        ['<leader>gp'] = ':Git push<CR>',
    }
    
    for key, cmd in pairs(git_maps) do
        vim.keymap.set('n', key, cmd, { desc = 'Git: ' .. cmd })
    end
end
```

### 4. **Event System Integration**
```lua
-- Custom event handling
vim.api.nvim_create_autocmd('User', {
    pattern = 'MyCustomEvent',
    callback = function(event)
        print('Custom event triggered:', vim.inspect(event.data))
    end
})

-- Trigger custom event
vim.api.nvim_exec_autocmds('User', {
    pattern = 'MyCustomEvent',
    data = { message = 'Hello from event!' }
})
```

## Plugin Development Best Practices

### 1. **Plugin Structure**
```lua
-- lua/myplugin/init.lua
local M = {}

M.config = {
    default_option = true,
    custom_value = 'default'
}

function M.setup(user_config)
    M.config = vim.tbl_deep_extend('force', M.config, user_config or {})
    -- Initialize plugin
end

function M.my_function()
    -- Plugin functionality
end

return M
```

### 2. **Error Handling**
```lua
-- Robust error handling
local function safe_require(module)
    local ok, result = pcall(require, module)
    if not ok then
        vim.notify(
            string.format('Failed to load %s: %s', module, result),
            vim.log.levels.ERROR
        )
        return nil
    end
    return result
end
```

### 3. **Configuration Validation**
```lua
-- Validate user configuration
local function validate_config(config)
    vim.validate({
        timeout = {config.timeout, 'number', true},
        pattern = {config.pattern, 'string', true},
        callback = {config.callback, 'function', true},
    })
end
```

### 4. **Lazy Loading Patterns**
```lua
-- Lazy loading for performance
local function load_module()
    if not _G.my_module then
        _G.my_module = require('my_module')
    end
    return _G.my_module
end
```

## Debugging Techniques

### 1. **Print Debugging**
```lua
-- Enhanced print for debugging
local function debug_print(...)
    local args = {...}
    for i, v in ipairs(args) do
        args[i] = vim.inspect(v)
    end
    print(table.concat(args, ' '))
end

debug_print('Variable:', my_var, 'Table:', my_table)
```

### 2. **Log File Debugging**
```lua
-- Write to log file
local function log_debug(message)
    local log_file = vim.fn.stdpath('cache') .. '/debug.log'
    local file = io.open(log_file, 'a')
    if file then
        file:write(os.date('%Y-%m-%d %H:%M:%S') .. ' ' .. message .. '\n')
        file:close()
    end
end
```

### 3. **Performance Profiling**
```lua
-- Simple performance measurement
local function profile_function(func, name)
    return function(...)
        local start = vim.fn.reltime()
        local result = func(...)
        local duration = vim.fn.reltimestr(vim.fn.reltime(start))
        print(string.format('%s took %s seconds', name, duration))
        return result
    end
end
```

## Configuration Testing Strategies

### 1. **Incremental Testing**
```lua
-- Test individual components
-- 1. Test in isolation
:lua require('config.keymaps')

-- 2. Test specific function
:lua require('config.functions').my_function()

-- 3. Test full integration
:source $MYVIMRC
```

### 2. **Backup & Rollback**
```lua
-- Create configuration snapshots
local function backup_config()
    local backup_dir = vim.fn.stdpath('config') .. '/backup/'
    vim.fn.mkdir(backup_dir, 'p')
    local timestamp = os.date('%Y%m%d_%H%M%S')
    -- Copy configuration files
end
```

### 3. **Feature Flags**
```lua
-- Conditional feature loading
local enable_experimental = vim.env.NVIM_EXPERIMENTAL == '1'

if enable_experimental then
    require('experimental.features')
end
```

## Advanced Customization Examples

### 1. **Dynamic Theming**
```lua
-- Auto-switch themes based on time
local function auto_theme()
    local hour = tonumber(os.date('%H'))
    if hour >= 6 and hour < 18 then
        vim.cmd('colorscheme catppuccin-latte')
    else
        vim.cmd('colorscheme catppuccin-mocha')
    end
end
```

### 2. **Context-aware Keymaps**
```lua
-- Different keymaps for different filetypes
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'go', 'lua', 'python'},
    callback = function()
        local ft = vim.bo.filetype
        if ft == 'go' then
            vim.keymap.set('n', '<leader>r', ':GoRun<CR>', {buffer = true})
        elseif ft == 'lua' then
            vim.keymap.set('n', '<leader>r', ':luafile %<CR>', {buffer = true})
        end
    end
})
```

### 3. **Workspace-specific Configuration**
```lua
-- Load project-specific settings
local function load_project_config()
    local project_config = vim.fn.getcwd() .. '/.nvim.lua'
    if vim.fn.filereadable(project_config) == 1 then
        dofile(project_config)
    end
end
```

This Lua/Neovim development environment provides powerful tools for customizing and extending your editor, making it perfectly tailored to your workflow.