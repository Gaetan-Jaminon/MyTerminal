-- Custom utility functions for Neovim configuration

local M = {}

-- Copy file/folder path function for Neo-tree
function M.copy_path_neotree()
  local current_path = vim.fn.expand('%:p')
  local target_path = vim.fn.input('Copy to: ', current_path)
  if target_path ~= '' and target_path ~= current_path then
    vim.cmd('!cp -r ' .. vim.fn.shellescape(current_path) .. ' ' .. vim.fn.shellescape(target_path))
  end
end

-- Move file/folder path function for Neo-tree
function M.move_path_neotree()
  local current_path = vim.fn.expand('%:p')
  local target_path = vim.fn.input('Move to: ', current_path)
  if target_path ~= '' and target_path ~= current_path then
    vim.cmd('!mv ' .. vim.fn.shellescape(current_path) .. ' ' .. vim.fn.shellescape(target_path))
  end
end

-- Remove trailing whitespace from current buffer
function M.remove_trailing_whitespace()
  local save_cursor = vim.fn.getpos(".")
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos(".", save_cursor)
end

-- Send text to terminal buffer (for Claude integration)
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

-- Export functions to global scope for backward compatibility
_G.CopyPathNeoTree = M.copy_path_neotree
_G.MovePathNeoTree = M.move_path_neotree
_G.RemoveTrailingWhitespace = M.remove_trailing_whitespace

return M