--Make line numbers default
vim.wo.number = true
vim.o.mouse = 'a' --Enable mouse mode

vim.opt.undofile = true  --Save undo history

--Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'nosplit'         -- Highlight substitutions while typing them
--Decrease update time
vim.opt.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.opt.termguicolors = true
vim.cmd [[silent! colorscheme sonokai]]

-- vim.o.completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.opt.swapfile = false
vim.opt.cursorline = true                   -- Highlight current line
vim.opt.showcmd = true                      -- Display incomplete commands
vim.opt.hidden = true                       -- Do not close open unsaved buffers when opening a new Vim instance
vim.opt.joinspaces = false                  -- Only one space when joining lines

-- Auto line break with full words
vim.opt.formatoptions = vim.opt.formatoptions + "w" -- Break on full wors
vim.opt.textwidth = 80
vim.opt.wrap = false
vim.opt.colorcolumn = "+1" -- Display ruler after 80 chars
-- vim.cmd [[highlight ColorColumn ctermbg=lightgrey guibg=lightgrey]] -- not needed in current theme

-- Softtabs, 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true                   -- < and > shift to the next tab stop defined by shiftwidth.
vim.opt.expandtab = true                    -- Always use spaces instead of tabs
vim.opt.breakindent = true                  -- Every wrapped line will continue visually indented
vim.opt.lazyredraw = true                   -- don't bother updating screen during macro playback

vim.opt.sidescrolloff = 3              -- Keep at least 3 lines left/right
vim.opt.scrolloff = 3                  -- Keep at least 3 lines above/below

-- Line between splits
vim.opt.fillchars = "vert:┃"             -- Heavy vertical (U+2503, UTF-8: E2 94 83)

vim.opt.splitright = true -- Prefer windows splitting to the right
vim.opt.splitbelow = true -- Prefer windows splitting to the bottom

-- Undofile
if root then
  vim.opt.undofile = false -- don't create root-owned files
else
  vim.opt.undofile = true  -- actually use undo files
end

-- Global statusline (nvim > 0.7)
if vim.fn.has('nvim-0.7') == 1 then
	vim.opt.laststatus=3
	vim.cmd [[highlight WinSeperator guibg=None]]
end
