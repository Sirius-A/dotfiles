# Vim Cheatsheet

## Debug mappings
To find out which plugn / custom binding is triggered for `<leader>f` use:
```
:verbose map <leader>c
```

## Find and replace (project-wide)
Uses https://github.com/wincent/ferret:

`<leader>a` - grep for string (populates quickfix list)
`<leader>s` - grep for word under cursor (populates quickfix list)
`<leader>r` - replace items in quickfix list with pattern (use `/search/replace/c` to confirm each replacement )


