# vim-import-kotlin
Auto detect and import for kotlin/java project

## Installation

### Dependencies

We need fzf to show dialog and pick the import from available candidates
```vim
Plug 'vijaymarupudi/nvim-fzf'
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'chau-bao-long/vim-import-kotlin'
```

## Quick Start
Config learn path, which point to your set of source code to learn import lines
```vim
let g:learn_path = $HOME . "/all-your-kotlin-projects-folder"
```
Run LearnImport to build import dictionary cache from library
```vim
:LearnImport<cr>
```
And map key to use it
```vim
nnoremap <space>il :KotlinImport<cr>
```
If you has [Comrade](https://github.com/beeender/Comrade) setup properly, this command will use import results from intelliJ
```vim
nnoremap <space>ia :ComradeImport<cr>
```
