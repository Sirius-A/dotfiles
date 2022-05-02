-- https://github.com/nvim-lualine/lualine.nvim
require'lualine'.setup {
  options = {
    theme = 'sonokai',
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  }
}
