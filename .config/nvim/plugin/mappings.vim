"-------------------------------------------------------------------------------
"                              Key Mappings
"-------------------------------------------------------------------------------
" j and k move visual line
nnoremap gj j
nnoremap gj j
nnoremap j gj
nnoremap k gk

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

" Delete to black hole register with X
noremap X "_d
nnoremap XX "_dd

" Select last pasted text
nmap vp `[v`]

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee "%"
