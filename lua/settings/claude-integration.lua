-- Claude Code + Zellij Integration
local M = {}

-- Auto-reload files changed by Claude Code
vim.opt.autoread = true
vim.opt.updatetime = 2000  -- Check every 2 seconds

-- Better terminal behavior in Zellij
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L"

-- Auto-check for file changes
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI'}, {
  pattern = '*',
  command = "if mode() != 'c' | checktime | endif",
})

-- Notification when file changes
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  pattern = '*',
  callback = function()
    vim.notify("File changed by Claude Code. Buffer reloaded!", vim.log.levels.WARN, {
      title = "File Reloaded",
      timeout = 2000,
    })
  end
})

-- Terminal keymaps
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Navigation (matches Zellij)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to split below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to split above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- Claude-specific keybindings
vim.keymap.set('n', '<leader>cr', ':checktime<CR>', { noremap = true, silent = true, desc = 'Reload changed files' })
vim.keymap.set('n', '<leader>cR', ':e!<CR>', { noremap = true, silent = true, desc = 'Force reload current file' })

-- Since you use Neotree
--vim.api.nvim_create_autocmd('VimEnter', {
--  pattern = '*',
--  callback = function()
--    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv()[0]) == 1 then
--      vim.cmd('Neotree filesystem reveal left')
--    end
--  end
--})

-- Change this part:
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv()[0]) == 1 then
      vim.cmd('NERDTree')  -- Changed from Neotree
    end
  end
})


-- Performance optimizations for SSH
if vim.env.SSH_CLIENT or vim.env.SSH_TTY then
  vim.opt.cursorline = false
  vim.opt.relativenumber = false
end

-- Optional: Send selected text to terminal (useful for Claude)
function M.send_to_terminal(text)
  local term_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
      term_buf = buf
      break
    end
  end

  if term_buf then
    local chan = vim.api.nvim_buf_get_var(term_buf, 'terminal_job_id')
    vim.api.nvim_chan_send(chan, text .. '\n')
  else
    vim.notify("No terminal buffer found!", vim.log.levels.ERROR)
  end
end

-- Optional keybindings for sending text to Claude
vim.keymap.set('n', '<leader>cs', function()
  M.send_to_terminal(vim.api.nvim_get_current_line())
end, { desc = 'Send current line to terminal' })

vim.keymap.set('v', '<leader>cs', function()
  local lines = vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'))
  M.send_to_terminal(table.concat(lines, '\n'))
end, { desc = 'Send selection to terminal' })

return M
