"  directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
"   " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

"Syntaxes & Language tools
Plug 'pangloss/vim-javascript' 
Plug 'leafgarland/typescript-vim'
Plug 'quramy/tsuquyomi' " Typescript client

" Initialize plugin system
call plug#end()

set encoding=utf-8
set noswapfile

" Editor settings
set number
set cursorline
set showcmd       " display incomplete commands
let g:loaded_python3_provider=1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

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

" Theme settings
syntax on
let g:enable_bold_font = 1
let g:airline_theme = "hybrid"
set background=dark
colorscheme hybrid_material

let g:javascript_plugin_jsdoc = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global OSX Clipboard Handling (tmux/vim/osx)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
