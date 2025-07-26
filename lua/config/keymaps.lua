-- Keymaps configuration - All keybindings in one place

local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "

-- === File Operations ===
-- Telescope file finder
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find files' })

-- Neo-tree file explorer
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', { desc = 'Open Neo-tree' })
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })

-- File copy/move operations
vim.keymap.set('n', '<leader>cf', ':lua CopyPathNeoTree()<CR>', opts)
vim.keymap.set('n', '<leader>mf', ':lua MovePathNeoTree()<CR>', opts)

-- === Text Editing ===
-- Remove trailing whitespace
vim.keymap.set('n', '<leader>w', ':lua RemoveTrailingWhitespace()<CR>', { desc = 'Remove trailing whitespace' })

-- === Terminal ===
-- Exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- === Window Navigation (Zellij compatible) ===
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to split below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to split above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- === Claude Code Integration ===
-- File reloading
vim.keymap.set('n', '<leader>cr', ':checktime<CR>', { desc = 'Reload changed files' })
vim.keymap.set('n', '<leader>cR', ':e!<CR>', { desc = 'Force reload current file' })

-- Send text to terminal (Claude workflow)
vim.keymap.set('n', '<leader>cs', function()
  require('config.functions').send_to_terminal(vim.api.nvim_get_current_line())
end, { desc = 'Send current line to terminal' })

vim.keymap.set('v', '<leader>cs', function()
  local lines = vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'))
  require('config.functions').send_to_terminal(table.concat(lines, '\n'))
end, { desc = 'Send selection to terminal' })

-- === Ansible Integration ===
-- Ansible doc search with Telescope
vim.keymap.set('n', '<leader>ad', ':lua ansible_doc_view()<CR>', opts)

-- === LSP Keybindings ===
-- Note: LSP keybindings are set in the LSP configuration file
-- to ensure they're only active when LSP is attached

-- === Go Development ===
-- Note: Go-specific keybindings are handled by go.nvim plugin