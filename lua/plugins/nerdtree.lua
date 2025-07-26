return {
  'preservim/nerdtree',
  lazy= false,
  cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" },
  keys = {
    { "<leader>e", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
  },
  config = function()
    -- NERDTree settings
    vim.g.NERDTreeWinSize = 25
    vim.g.NERDTreeMinimalUI = 1
    vim.g.NERDTreeDirArrows = 1
    vim.g.NERDTreeShowHidden = 1

    -- Auto close nvim if NERDTree is only window left
    vim.cmd([[
      autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    ]])
  end
}
