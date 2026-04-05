" Line config
syntax on
set number
"set relativenumber
"set nowrap
set scrolloff=4
"set cursorline
":highlight Cursorline cterm=bold ctermbg=black

" Tabs config
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Search config
set smartcase
set ignorecase
set incsearch
set hlsearch

" Finding files
set path+=**
set wildmenu

" Splits
set splitright
set splitbelow

" Remap CapsLock to Esc
"au VimEnter * :silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"au VimLeave * :silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" F9 runs `build.sh`
nnoremap <silent> <F9> :w<CR>:!sh build.sh<CR>
inoremap <silent> <F9> <Esc>:w<CR>:!sh build.sh<CR>

" Colors
if !has('gui_running')
    set t_Co=256
endif
"set termguicolors

" Status Line
hi slineS0 guibg=Cyan ctermbg=3 guifg=Black ctermfg=0 
set laststatus=2
set statusline+=\%#CursorLineNr#  " #slineS0#
set statusline+=\%#Search#
set statusline+=\[%n] " buffer number
set statusline+=\ %f " rel path to the file in buffer 
set statusline+=\ %r " read only flag
set statusline+=\%m " modified flag
set statusline+=\ %= " separator
set statusline+=\%y " type of the file in buffer
set statusline+=\%#CursorLineNr#
set statusline+=\ (%p%%) " percentage through file in lines
set statusline+=\ %l " current line number
set statusline+=\/%L " total number of lines
set statusline+=\ :\ %c " column number

set showcmd

" Insert mode remaps / auto-completions
" - Double Quotes
inoremap "      ""<Left>
inoremap ""     ""
" - Single Quotes
inoremap '      ''<Left>
inoremap ''     ''
" - Parens
inoremap (      ()<Left>
inoremap ()     ()
" - Brackets
inoremap [      []<Left>
inoremap []     []
" - Braces
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {}     {}

set showmatch

