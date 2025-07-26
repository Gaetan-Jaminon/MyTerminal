-- Neovim Configuration Entry Point
-- Modular configuration using Lazy.nvim plugin manager

-- Bootstrap Lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Load core configuration
require('config.options')      -- Neovim options and settings
require('config.keymaps')      -- All keybindings
require('config.autocmds')     -- Auto commands
require('config.functions')    -- Custom utility functions

-- Load legacy settings (will be merged gradually)
require('settings.claude-integration') -- Claude-specific integrations

-- Setup Lazy.nvim and load all plugins
require("lazy").setup("plugins", {
  root = vim.fn.stdpath("config") .. "/plugins",
})