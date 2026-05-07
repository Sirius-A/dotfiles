-- Key mappings
local map = vim.keymap.set

-- j/k move by visual line; gj/gk move by physical line (swapped from default)
map('n', 'j', 'gj', { desc = 'Down by visual line' })
map('n', 'k', 'gk', { desc = 'Up by visual line' })
map('n', 'gj', 'j', { desc = 'Down by physical line' })
map('n', 'gk', 'k', { desc = 'Up by physical line' })

-- Split navigation with Ctrl + hjkl
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to split below' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to split above' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- Escape from insert / terminal mode without reaching for Esc
map('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })
map('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
map('i', 'kj', '<Esc>', { desc = 'Exit insert mode' })
map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- Indent / unindent with Tab and Shift-Tab
map('n', '<Tab>',   '>>_',   { desc = 'Indent line' })
map('n', '<S-Tab>', '<<_',   { desc = 'Unindent line' })
map('i', '<S-Tab>', '<C-d>', { desc = 'Unindent line' })
map('v', '<Tab>',   '>gv',   { desc = 'Indent selection (keep selection)' })
map('v', '<S-Tab>', '<gv',   { desc = 'Unindent selection (keep selection)' })

-- Keep selection after indenting with < / >
map('v', '<', '<gv', { desc = 'Unindent (keep selection)' })
map('v', '>', '>gv', { desc = 'Indent (keep selection)' })

-- Close current buffer without closing the window
map('n', '<leader>q', ':bp<CR>:bd #<CR>', { desc = 'Close current buffer', silent = true })

-- Toggle spellcheck
map('n', '<F7>', ':setlocal spell! spell?<CR>',      { desc = 'Toggle spellcheck' })
map('i', '<F7>', '<C-o>:setlocal spell! spell?<CR>', { desc = 'Toggle spellcheck' })

-- Delete to the black-hole register (no clipboard pollution)
map({ 'n', 'v', 'o' }, 'X',  '"_d',  { desc = 'Delete without yanking' })
map('n',               'XX', '"_dd', { desc = 'Delete line without yanking' })

-- Select last pasted text (uses `[ and `] marks)
map('n', 'vp', '`[v`]', { desc = 'Select last pasted text', remap = true })

-- Save with sudo when nvim wasn't started as root
map('c', 'w!!', [[w !sudo tee "%"]], { desc = 'Save with sudo' })
