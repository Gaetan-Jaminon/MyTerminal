-- Autocmds configuration

-- Automatically set filetype to yaml.ansible for Ansible files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.yml", "*.yaml"},
  callback = function()
    if vim.fn.getcwd():match("ansible") then
      vim.cmd("set ft=yaml.ansible")
    end
  end,
  desc = "Set Ansible filetype for YAML files in ansible directories"
})

-- Automatically remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    require('config.functions').remove_trailing_whitespace()
  end,
  desc = "Remove trailing whitespace on save"
})

-- Auto-check for file changes (Claude integration)
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI'}, {
  pattern = '*',
  command = "if mode() != 'c' | checktime | endif",
  desc = "Auto-check for external file changes"
})

-- Notification when file changes (Claude integration)
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  pattern = '*',
  callback = function()
    vim.notify("File changed by Claude Code. Buffer reloaded!", vim.log.levels.WARN, {
      title = "File Reloaded",
      timeout = 2000,
    })
  end,
  desc = "Notify when file is reloaded due to external changes"
})

-- Auto-open Neo-tree when opening a directory
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv()[0]) == 1 then
      vim.cmd('Neotree filesystem reveal left')
    end
  end,
  desc = "Auto-open Neo-tree when starting with a directory"
})