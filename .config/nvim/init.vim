"  directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
"   " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Editor Settings
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible' " Default configuration
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' " Comment stuff out using `gc` -  https://github.com/tpope/vim-commentary
Plug 'tpope/vim-repeat'     " Allows plugins to use repat the whole operation with '.'
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespaces. Also adds :StripWhitespace function
Plug 'wincent/terminus' " Improve Vim inside the terminal
Plug 'christoomey/vim-tmux-navigator' " Switch between splits and tmux panes

Plug 'mhinz/vim-janah' " Colorscheme
Plug 'kristijanhusak/vim-hybrid-material' " Colorscheme https://github.com/kristijanhusak/vim-hybrid-material

" Extensions
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive' " Git utils
Plug 'tpope/vim-eunuch'   " Unix File helpers
Plug 'ctrlpvim/ctrlp.vim' " Fizzy File Finder
Plug 'Shougo/denite.nvim' " Allows 'panel' creation
Plug 'scrooloose/nerdtree' " File Browser / explorer
Plug 'Xuyuanp/nerdtree-git-plugin' " Show Git status of files in NerdTree
Plug 'mhinz/vim-startify' " Startpage

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf.vim'

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
Plug 'w0rp/ale'                     " Asynchronous lint engine
Plug 'sheerun/vim-polyglot'         " A collection of language packs
Plug 'pangloss/vim-javascript'
Plug 'bdauria/angular-cli.vim'      " Integration with angulat cli and file navigation utilities
Plug 'HerringtonDarkholme/yats.vim' " Syntax highlighting
Plug 'mhartington/nvim-typescript', {'do': './install.sh'} " TS autocompletion
Plug 'elzr/vim-json'                " Better json support
Plug 'sbdchd/neoformat'             " Auto formatting
Plug 'ap/vim-css-color'             " Show colors in css files
Plug 'godlygeek/tabular'      			" Formatting for Markdown tables
Plug 'plasticboy/vim-markdown'      " Better Markdown support

" Icons for AAALLL THE THINGS!! (should be loaded at the end)
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

"-------------------------------------------------------------------------------
"                             Editor Settings
"-------------------------------------------------------------------------------
set encoding=utf-8
set noswapfile
set path+=**                     " Include all subdrirectory when openening a project root

set number                       " Show line numbers in gutter
set cursorline                   " Highlight current line
set showcmd                      " Display incomplete commands
set hidden                       " Do not close open unsaved buffers when opening a new Vim instance
set switchbuf=usetab             " Try to reuse windows/tabs when switching buffers
set mouse=n                      " Enable mouse for resizing and stuff
set showmatch                    " Highlight search results
set formatoptions+=j             " Remove comment leader when joining comment lines
set nojoinspaces                 " Only one space when joining lines

" Auto line break with full words
set formatoptions+=w
set tw=80
" Display ruler after 80 chars
set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround                   " < and > shift to the next tab stop defined by shiftwidth.
set expandtab                    " Always use spaces instead of tabs
set lazyredraw                   " don't bother updating screen during macro playback

" Search and replace
set ignorecase smartcase         " Ignore case unless a capital letter is entered
set smartcase                    " Ignore case if search pattern is all lowercase,case-sensitive otherwise
if exists('&inccommand')
  set inccommand=nosplit         " Highlight substitutions while typing them
endif

set sidescrolloff=3              " Keep at least 3 lines left/right
set scrolloff=3                  " Keep at least 3 lines above/below

" Line between splits
set fillchars=vert:┃             " Heavy vertical (U+2503, UTF-8: E2 94 83)

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright


" Persintent undo
if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    set undodir=~/.local/.vim/tmp/undo
    set undodir+=~/.vim/tmp/undo      " keep undo files out of the way
    set undodir+=.
    set undofile                      " actually use undo files

    if !isdirectory('~/.local/.vim/tmp/undo')
      call mkdir('~/.local/.vim/tmp/undo', 'p')
    endif
  endif
endif

let g:javascript_plugin_jsdoc = 1 " From 'pangloss/vim-javascript'
let g:vim_json_syntax_conceal = 0 " Disable hiding of quotation marks in normal mode

let mapleader = "\<Space>"

" Theme settings
syntax on
let g:airline_theme = "wombat"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1      " Show lint status in airline

set noshowmode      " Airline shows mode, so hide default mode
set background=dark " (Needs to be placed before colorscheme definition)
"colorscheme hybrid_reverse
autocmd ColorScheme janah highlight Normal ctermbg=235
colorscheme janah

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


if has('syntax')
  set spellcapcheck=                  " don't check for capital letters at start of sentence
endif

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

"---------------------------------Ale----------------------------------------
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_fixers = {
      \ 'scss': ['sasslint'],
      \ 'typescript': [ 'tslint', 'eslint' ],
      \ }
"---------------------------------Ctrl P----------------------------------------
" https://github.com/ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'cra'
let g:ctrlp_show_hidden = 1

"-------------------------------NERDTree----------------------------------------
let g:NERDTreeShowIgnoredStatus = 1 " Highlight ignored files (a heavy feature; may cost much more time)
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1

" Open NERDTree automatically when vim starts up and no files we specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | NERDTree | endif
" Open NERDTree automatically when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | execute 'NERDTree' argv()[0] | wincmd p | ene | endif

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"----------------------------------fzf------------------------------------------
"Hide statusline when fzf opens a :terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"-------------------------------------------------------------------------------
"                        	Syntax and Languages
"-------------------------------------------------------------------------------
" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
autocmd VimEnter * if globpath('.,..','node_modules/@angular') != '' | call angular_cli#init() | endif
"-------------------------------------------------------------------------------
"                             Command Mappings
"-------------------------------------------------------------------------------
" Replace a builtin commands using cabbrev
" http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
command! -nargs=+ CommandAlias call <SID>CommandAlias(<f-args>)
function! s:CommandAlias(abbreviation, expansion) " {{{
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

CommandAlias E e
CommandAlias E! e!
CommandAlias Q q
CommandAlias Q! q!
CommandAlias QA qa
CommandAlias Qa qa
CommandAlias qA qa
CommandAlias QA! qa!
CommandAlias Qa! qa!
CommandAlias qA! qa!
CommandAlias W w
CommandAlias WQ wq
CommandAlias Wq wq
CommandAlias wQ wq
CommandAlias WQ! wq!
CommandAlias Wq! wq!
CommandAlias wQ! wq!

"-------------------------------------------------------------------------------
"                              Key Mappings
"-------------------------------------------------------------------------------
" Easier Split Navigation via Ctrl + <Vim direction>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Get out of insert mode without hitting esc
imap jj <Esc>
imap jk <Esc>
imap kj <Esc>
tnoremap <Esc> <C-\><C-n> " terminal

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

" Fix lint errors
nnoremap <A-f> :ALEFix<CR>

" Delete to black hole register with X
noremap X "_d
nnoremap XX "_dd

" Select last pasted text
nmap vp `[v`]

" Auto completion seletion using ctrl + movement keys
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"

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

