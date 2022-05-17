require('telescope').load_extension('fzf')

-- smart file search: use git files if in git and files if not
-- Source: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
-- telescope-config.lua
local project_files = function()
  local ok = pcall(function()
    require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({}))
  end)
  if not ok then require"telescope.builtin".find_files(require('telescope.themes').get_dropdown({})) end
end


local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-s>"] = actions.select_horizontal,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden"
    }
  },
  pickers = {
    find_files = { hidden = true }
  }
}

--Add leader shortcuts
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files()
end)
vim.keymap.set('n', '<C-p>', function()
  project_files()
end)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').grep_string)
vim.keymap.set('v', '<leader>fg', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>' )
vim.keymap.set('v', '<C-f>',      'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>' )
vim.keymap.set('n', '<leader>fG', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

-- Search for vim config files
vim.keymap.set('n', '<leader>fv', function()
  require('telescope.builtin').find_files({search_dirs = {"$HOME/.config/nvim/"}})
end)
