-- Neovim options configuration

-- === Editor Behavior ===
vim.opt.expandtab = true          -- Use spaces instead of tabs
vim.opt.tabstop = 2               -- Number of spaces tabs count for
vim.opt.softtabstop = 2           -- Number of spaces tabs count for while editing
vim.opt.shiftwidth = 2            -- Size of an indent
vim.opt.mouse = ""                -- Disable mouse support
vim.opt.swapfile = false          -- Disable swap files
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- === UI Settings ===
vim.opt.number = true             -- Show line numbers
vim.g.background = "light"        -- Set background mode

-- === Auto-reload Settings ===
vim.opt.autoread = true           -- Auto-reload files changed outside vim
vim.opt.updatetime = 2000         -- Check for changes every 2 seconds

-- === Terminal Settings ===
vim.opt.title = true              -- Set terminal title
vim.opt.titlestring = "%<%F%=%l/%L" -- Terminal title format

-- === Zellij-specific Optimizations ===
if vim.env.ZELLIJ then
  vim.opt.mouse = ""              -- Disable mouse in Zellij
  vim.opt.termguicolors = true    -- Better color support
  vim.opt.lazyredraw = true       -- Optimize for terminal multiplexer
  vim.opt.ttyfast = true          -- Faster terminal
  vim.env.COLORTERM = "truecolor" -- Set proper terminal behavior
end

-- === SSH Optimizations ===
if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
  vim.opt.cursorline = false      -- Disable cursor line over SSH
  vim.opt.relativenumber = false  -- Disable relative numbers over SSH
end