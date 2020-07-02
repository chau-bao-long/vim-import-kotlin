# vim-import-kotlin
Auto detect and import for kotlin/java project

## Installation

### Dependencies
This plugin work best when combine with these plugins:
- Fzf
```vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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
