-- Automatically set filetype to yaml.ansible for Ansible files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.yml", "*.yaml"},
  callback = function()
    if vim.fn.getcwd():match("ansible") then
      vim.cmd("set ft=yaml.ansible")
    end
  end,
})


