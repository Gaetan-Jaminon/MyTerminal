return {
  -- ansible-doc.vim: Provides ansible-doc integration
  {
   "takelley1/ansible-doc.vim",
   config = function()
   -- Key mappings for ansible-doc
     vim.api.nvim_set_keymap('n', '<leader>d', ':AnsibleDocFloat<CR>', { noremap = true, silent = true })
     vim.api.nvim_set_keymap('n', '<leader>v', ':AnsibleDocVSplit<CR>', { noremap = true, silent = true })
   end
  },
}
