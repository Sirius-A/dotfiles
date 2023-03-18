-- Install lazy.nvim
-- https://github.com/folke/lazy.nvim#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'tpope/vim-fugitive', -- Git commands in nvim
  'tpope/vim-surround',
  'tpope/vim-commentary', -- Comment stuff out using `gc` -  https://github.com/tpope/vim-commentary
  'tpope/vim-repeat',
  'simeji/winresizer', -- Resize window mode via CTRL + e
  'wellle/targets.vim', -- Additional text objects (allows ci[ for example)
  'wsdjeg/vim-fetch', -- Make vim understand my-file:80:4 to jump to line 80
  'smithbm2316/centerpad.nvim', -- Center a buffer


  -- Extensions
  {
    'goolord/alpha-nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  },
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- Add git related info in the signs columns and popups
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  'will133/vim-dirdiff', -- Compare whole directories (:DirDiff dir1 dir2)

  -- Look and feel
  'sainnhe/sonokai', -- colorscheme with tree sitter support
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  { -- Highlight active window
    "nvim-zh/colorful-winsep.nvim",
    config = function ()
      require('colorful-winsep').setup()
    end
  },

  -- Languages and Syntax
   'gpanders/editorconfig.nvim',
   { 'neoclide/coc.nvim', branch = 'release' }, -- Completion and LSP support
   'rafcamlet/coc-nvim-lua',
   'arecarn/vim-spell-utils',      -- Keybinds for spellchecker
  ({ "iamcco/markdown-preview.nvim", build = "cd app && npm install", init = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, }),
   'ferrine/md-img-paste.vim',
   'bdauria/angular-cli.vim',
   { 'junegunn/fzf', build = function() vim.fn['fzf#install'](0) end },-- Will clone fzf in ~/.fzf and run install script
   {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'lervag/vimtex',

  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  --Highlight, edit, and navigate code using a fast incremental parsing library
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    }
  },

  -- Icons for AAALLL THE THINGS!! (should be loaded at the end)
  -- use 'ryanoasis/vim-devicons'
  'kyazdani42/nvim-web-devicons',
})
