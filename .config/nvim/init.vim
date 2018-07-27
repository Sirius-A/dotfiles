"  directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
"   " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Editor Settings
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible' " Default configuration
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' " Comment stuff out using `gc` -  https://github.com/tpope/vim-commentary
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespaces. Also adds :StripWhitespace function

Plug 'kristijanhusak/vim-hybrid-material' " Colorscheme https://github.com/kristijanhusak/vim-hybrid-material

" Extensions
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim' " Fizzy File Finder
Plug 'Shougo/denite.nvim' " Allows 'panel' creation
Plug 'scrooloose/nerdtree' " File Browser / explorer
Plug 'Xuyuanp/nerdtree-git-plugin' " Show Git status of files in NerdTree

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Will clone fzf in ~/.fzf and run install script

" Deoplete - asynchronous completion framework
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1

" Syntaxes & Language tools
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim' " Syntax highlighting
Plug 'mhartington/nvim-typescript' " TS autocompletion
Plug 'elzr/vim-json'
Plug 'sbdchd/neoformat'

" Icons for AAALLL THE THING!! (should be loaded at the end)
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

"-------------------------------------------------------------------------------
"                             Editor Settings
"-------------------------------------------------------------------------------
set encoding=utf-8
set noswapfile

set number
set cursorline
set showcmd              " Display incomplete commands
set hidden               " Do not close open unsaved buffers when openening a new Vim instance
set mouse=n              " Enable mouse for resizing and stuff
set showmatch

set ignorecase smartcase " Ignore case unless a captial letter is entered
set smartcase            " Ignore case if search pattern is all lowercase,case-sensitive otherwise

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

let mapleader = "\<Space>"
let g:javascript_plugin_jsdoc = 1 " From 'pangloss/vim-javascript'

" Theme settings
syntax on
let g:airline_theme = "wombat"
let g:airline_powerline_fonts = 1
set background=dark
colorscheme hybrid_reverse

" Restore last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Show recent log entries in commit messages
function! s:EnhanceCommitMessage()
  " Avoid line wrapping
  let textwidth = &textwidth
  let &textwidth = 0

  " Return if log entries were already added
  normal gg0
  if search('^# Latest commits:$')
    return
  endif

  if !search('^# Please enter the commit message')
    return
  endif

  normal V
  call search('^# Changes to be committed:$')
  normal kkd

  normal O# Latest commits:

  let logCommand = 'git log -n 5 --no-color --no-decorate --pretty=%s'
  for line in split(system(logCommand), '\n')
    execute 'normal o#  - ' . line
  endfor

  normal o#
  normal gg0

  " Insert new line for empty commit messages
  if search('^# Latest commits:$', 'n') == 2
    normal O
    startinsert
  endif

  let &textwidth = textwidth
endfunction
autocmd FileType gitcommit call <SID>EnhanceCommitMessage()

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files..
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

"-------------------------------NERDTree----------------------------------------
let g:NERDTreeShowIgnoredStatus = 1 " Highlight ignored files (a heavy feature may cost much more time)

"open NERDTree automatically when vim starts up and no files we specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"-------------------------------------------------------------------------------
"                        	Syntax and Languages
"-------------------------------------------------------------------------------
" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
"-------------------------------------------------------------------------------
"                              Key Mappings
"-------------------------------------------------------------------------------
" Easier Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Get out of insert mode without hitting esc
imap jj <Esc>
imap jk <Esc>
imap kj <Esc>

" Indent with tab
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Keep lines selected after indenting them
vnoremap < <gv
vnoremap > >gv

" Close current buffer
nnoremap <leader>q :bp<cr>:bd #<cr>

"Toggle spellcheck
nnoremap <F7> :setlocal spell! spell?<CR>
inoremap <F7> <C-o>::setlocal spell! spell?<CR>

" Delete to black hole register with X
noremap X "_d
nnoremap XX "_dd

" Select last pasted text
nmap vp `[v`]

" CtrlP
" https://github.com/ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" Open / close NERDTree
map <C-n> :NERDTreeToggle<CR>
" Show currently open file in NT
map <A-n> :NERDTreeFind<CR>
" Focus NT from anywhere
map <A-b> :NERDTree<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global OSX Clipboard Handling (tmux/vim/osx)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

