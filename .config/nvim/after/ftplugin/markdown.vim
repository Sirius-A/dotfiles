"https://github.com/ferrine/md-img-paste.vim
nnoremap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

let g:mdip_imgdir = 'images'

" Spellcheck
setlocal spell
setlocal complete+=kspell
setlocal spelllang+=de
