return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash', 'c', 'css', 'html', 'json', 'lua', 'luadoc',
      'markdown', 'markdown_inline', 'python', 'query', 'scss',
      'vim', 'vimdoc',
    },
    auto_install = true,
    highlight = {
      enable = true,
      disable = { 'html' }, -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1788
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { 'python' } },
  },
}
