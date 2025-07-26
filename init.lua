-- Define the path for Lazy.nvim within the Neovim configuration folder (~/.config/nvim/lazy/lazy.nvim)
-- This ensures Lazy.nvim is stored within the Neovim config instead of the default data path
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
--
-- Check if Lazy.nvim is not already installed at the defined path
if not vim.loop.fs_stat(lazypath) then
  -- Clone Lazy.nvim from GitHub if it's not present in the path
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",  -- Clone only the essential parts of the repo
    "https://github.com/folke/lazy.nvim.git",  -- Lazy.nvim repository URL
    "--branch=stable",     -- Use the latest stable release of Lazy.nvim
    lazypath,              -- The installation path for Lazy.nvim
  })
end

-- Prepend Lazy.nvim's path to the runtime path (rtp) to make it available for Neovim
vim.opt.runtimepath:prepend(lazypath)

-- Load general Neovim options from a separate settings file
-- This keeps the init.lua clean and organized
require('settings.options')

-- Load custom key mappings from a separate file to avoid clutter in init.lua
require('settings.keymaps')

-- Load auto commands (e.g., filetype detection) from a dedicated file
-- Helps maintain a modular configuration
require('settings.autocmds')

require('settings.claude-integration')

-- Setup Lazy.nvim and load all plugins defined in the 'plugins' directory
-- This is where your plugin configurations will live (e.g., Telescope, LSP, etc.)
require("lazy").setup("plugins", {
  root = vim.fn.stdpath("config") .. "/plugins",  -- Install all plugins in ~/.config/nvim/plugins
})

vim.api.nvim_set_keymap('n', '<leader>cf', ':lua CopyPathNeoTree()<CR>', { noremap = true, silent = true })

function CopyPathNeoTree()
    local current_path = vim.fn.expand('%:p')  -- Get the current file or folder path
    local target_path = vim.fn.input('Copy to: ', current_path)  -- Prompt with current path
    vim.cmd('!cp -r ' .. vim.fn.shellescape(current_path) .. ' ' .. vim.fn.shellescape(target_path))
end

vim.api.nvim_set_keymap('n', '<leader>mf', ':lua MovePathNeoTree()<CR>', { noremap = true, silent = true })

function MovePathNeoTree()
    local current_path = vim.fn.expand('%:p')  -- Get the current file or folder path
    local target_path = vim.fn.input('Move to: ', current_path)  -- Prompt with current path
    vim.cmd('!mv ' .. vim.fn.shellescape(current_path) .. ' ' .. vim.fn.shellescape(target_path))
end

-- Function to remove trailing whitespace
function RemoveTrailingWhitespace()
  vim.cmd([[%s/\s\+$//e]])
end

-- Keybinding to remove trailing whitespace
vim.api.nvim_set_keymap('n', '<Leader>w', ':lua RemoveTrailingWhitespace()<CR>', { noremap = true, silent = true })

-- Automatically remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    RemoveTrailingWhitespace()
  end,
})

vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })

