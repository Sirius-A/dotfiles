require'nvim-treesitter.configs'.setup {
  ensure_installed = { "scss", "css", "lua", "c", "python", "json", "markdown", "html" },

  highlight = {
    enable = true,
    disable = { 'html' }, -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1788
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { 'python' } },
}
