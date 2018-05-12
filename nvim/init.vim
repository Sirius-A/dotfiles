"  directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
"   " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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

"Ctrl+T fuzzy finder 
set rtp+=~/.fzf

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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" )
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>
