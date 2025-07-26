
local opts = { noremap = true, silent = true }


-- Key mapping to trigger ansible-doc search with Telescope
vim.api.nvim_set_keymap('n', '<leader>ad', ':lua ansible_doc_view()<CR>', opts )
vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree filesystem reveal left<CR>', opts )

