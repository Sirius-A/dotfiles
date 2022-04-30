-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone --depth 1 https://github.com/wbthomason/packer.nvim' .. install_path)
end

if vim.fn.has('nvim-0.7') == 1 then
  local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'plugins.lua' })
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  -- Editor Settings
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary' -- Comment stuff out using `gc` -  https://github.com/tpope/vim-commentary
  use 'simeji/winresizer' -- Resize window mode via CTRL + e
  use 'wellle/targets.vim' -- Additional text objects (allows ci[ for example)
  use 'wsdjeg/vim-fetch' -- Make vim understand my-file:80:4 to jump to line 80

  -- Extensions
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'will133/vim-dirdiff' -- Compare whole directories (:DirDiff dir1 dir2)

  -- Look and feel
  use 'sainnhe/sonokai' -- colorscheme with tree sitter support
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline

  -- Languages and Syntax
  use { 'neoclide/coc.nvim', branch = 'release' } -- Completion and LSP support
  use 'arecarn/vim-spell-utils'      -- Keybinds for spellchecker
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  use 'ferrine/md-img-paste.vim'

  use { 'junegunn/fzf', run = function() vim.fn['fzf#install'](0) end } -- Will clone fzf in ~/.fzf and run install script
  use 'junegunn/fzf.vim'
  use 'ibhagwan/fzf-lua' 

  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-angular'

  -- Icons for AAALLL THE THINGS!! (should be loaded at the end)
  -- use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
end)
