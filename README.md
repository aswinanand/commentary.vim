## Why another comment/uncomment plugin?

I had some mappings and autocommands for commenting and uncommenting code in 
various languages. When I started VimL, I thought it would be a good idea to 
create a plugin by moving those maps & autocommands to a plugin &
commentary.vim was born.

If you are creating a new vim plugin & want to get started, this code should 
be of help.

## How to Install

Pathogen is the easiest way to install this plugin. Just go to 
`~/.vim/bundle` and run:
```
git clone https://github.com/aswinanand/commentary.vim.git
```
or add it as a git submodule.

## Usage
This plugin defines two commands namely `:Commentary` and `:Uncommentary`. In 
normal mode just type `:Commentary` and the current line will be commented. In
visual mode, select the lines and then type `:Commentary`. Do the same for 
uncommenting, except that, run `:Uncommentary` instead of `:Commentary`.

The easiest way would be to drop mappings in your `~/.vimrc`. I have mapped 
`F5` key for commenting code and `F6` for uncommenting code. This is how the 
mapping looks:
```
" Comment lines by pressing F5
nnoremap <F5> :Commentary<cr>
inoremap <F5> <esc>:Commentary<cr>i
vnoremap <F5> :Commentary<cr>

" Uncomment lines by pressing F6
nnoremap <F6> :Uncommentary<cr>
inoremap <F6> <esc>:Uncommentary<cr>i
vnoremap <F6> :Uncommentary<cr>
```
