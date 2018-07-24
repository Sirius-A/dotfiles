"  directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
"   " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Editor Settings
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible' " Default configuration
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' " Comment stuff out using `gc` -  https://github.com/tpope/vim-commentary

" Extensions
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ctrlpvim/ctrlp.vim' " Fizzy File Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " will clone fzf in ~/.fzf and run install script
Plug 'Shougo/denite.nvim' " Allows 'panel' creation

"deoplete synchronous completion framework 
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Syntaxes & Language tools
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim' " Syntax highlighting
" TS autocompletion
Plug 'mhartington/nvim-typescript'

let g:deoplete#enable_at_startup = 1
" Initialize plugin system
call plug#end()

"-------------------------------------------------------------------------------
"                             Editor Settings 
"-------------------------------------------------------------------------------
set encoding=utf-8
set noswapfile

" Editor settings
set number
set cursorline
set showcmd       " Display incomplete commands
set hidden        " Do not close open unsaved buffers when openening a new Vim instance

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Open new splits at a more logical place
set splitbelow
set splitright

" Theme settings
syntax on
let g:enable_bold_font = 1
let g:airline_theme = "wombat"
let g:airline_powerline_fonts = 1
set background=dark
colorscheme hybrid_material

let g:javascript_plugin_jsdoc = 1 "From 'pangloss/vim-javascript' 

" Restore last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"-------------------------------------------------------------------------------
"                              Key Mappings
"-------------------------------------------------------------------------------
" Easier Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" get out of insert mode without hitting esc
imap jj <Esc>
imap jk <Esc>
imap kj <Esc>

" keep lines selected after indenting them
vnoremap < <gv
vnoremap > >gv

"toggle spellcheck
nnoremap <F7> :setlocal spell! spell?<CR>
inoremap <F7> <C-o>::setlocal spell! spell?<CR>

" CtrlP
" https://github.com/ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
if executable('ag')
	" Use Ag over Grep
	set grepprg=ag\ --nogroup\ --nocolor
  "use ag in CtrlP for listing files. Lightning fast and respects.gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global OSX Clipboard Handling (tmux/vim/osx)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
