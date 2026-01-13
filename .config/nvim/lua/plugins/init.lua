return {
  'tpope/vim-fugitive', -- Git commands in nvim
  'tpope/vim-commentary', -- Comment stuff out using `gc` -  https://github.com/tpope/vim-commentary
  'tpope/vim-repeat',
  'simeji/winresizer', -- Resize window mode via CTRL + e
  'wellle/targets.vim', -- Additional text objects (allows ci[ for example)
  'wsdjeg/vim-fetch', -- Make vim understand my-file:80:4 to jump to line 80
  'smithbm2316/centerpad.nvim', -- Center a buffer
  { 'ggandor/leap.nvim', keys = 's'}, -- Jump navigation
  { 'smjonas/live-command.nvim', event = 'CmdlineEnter' },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
          })
    end
  },


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
   'bdauria/angular-cli.vim',
   'ekickx/clipboard-image.nvim',
   {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  },
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  'lervag/vimtex',
  -- { -- Highlight, edit, and navigate code
  --   'nvim-treesitter/nvim-treesitter',
  --   build = ':TSUpdate',
  --   main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  --   -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  --   opts = {
  --     ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
  --     -- Autoinstall languages that are not installed
  --     auto_install = true,
  --     highlight = {
  --       enable = true,
  --       -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
  --       --  If you are experiencing weird indenting issues, add the language to
  --       --  the list of additional_vim_regex_highlighting and disabled languages for indent.
  --       additional_vim_regex_highlighting = { 'ruby' },
  --     },
  --     indent = { enable = true, disable = { 'ruby' } },
  --   },
  --   -- There are additional nvim-treesitter modules that you can use to interact
  --   -- with nvim-treesitter. You should go explore a few and see what interests you:
  --   --
  --   --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --   --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --   --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- },
  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   dependencies = {
  --     {"nvim-lua/plenary.nvim"},
  --     {"nvim-treesitter/nvim-treesitter"}
  --   }
  -- },

  -- Icons for AAALLL THE THINGS!! (should be loaded at the end)
  'kyazdani42/nvim-web-devicons',
}
