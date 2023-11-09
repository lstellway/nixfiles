" Disable compatibility mode
set nocompatible

" Use absolute line numbers
set number
" Use relative line numbers
" set relativenumber

" tell vim where to put its backup files
set backupdir=/tmp

" tell vim where to put swap files
set dir=/tmp

" Change default direction of splits
set splitbelow splitright

" change the mapleader
" let mapleader="\<Space>"

" Always show status line
set laststatus=2

" Always show tab line
set showtabline=2

" Indentation
autocmd FileType javascript,javascriptreact,typescript,typescriptreact,php setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab smarttab
autocmd BufNewFile,BufRead *.md set filetype=vimwiki
autocmd BufNewFile,BufRead *.plist set filetype=xml

" Allow backspace
set backspace=indent,eol,start

" Helper function to set Indentation
" Usage:
"   :Indentation [NUMBER]
function! SetIndentation(...) abort
  let size = get(a:, 1, 2)
  let cmd = 'setlocal shiftwidth='.size.' tabstop='.size.' softtabstop='.size.' expandtab smarttab'
  execute cmd
endfunction
command! -nargs=* Indentation call SetIndentation(<q-args>)

" Helper function to clear swap files
function! ClearSwapFiles() abort
  call system('rm -f /tmp/*.swp')
endfunction
command! -nargs=0 ClearSwap call ClearSwapFiles()

" Copy file name to system clipboard
function! FilenameToClipboard() abort
  " Set the system register value = the register value of the current file path
  let @+=@%
endfunction
command! -nargs=0 Clipboard call FilenameToClipboard()

" Go to definition
nnoremap <leader>i :vsplit \| :call CocAction('jumpDefinition')<CR>
nnoremap <Esc>i :split \| :call CocAction('jumpDefinition')<CR>

" Delete buffer
nnoremap <C-X> :bdelete<CR>

" Reload VIM configuration
nnoremap <leader>r :source $MYVIMRC<CR>

" Map tab to switch tabs
nmap <Tab> :tabnext<CR>
map <S-Tab> :tabprevious<CR>

" Fix slow TypeScript
" @see https://jameschambers.co.uk/vim-typescript-slow
syntax on
" Use new regular expression engine
set re=0

" Optimize syntax highlighting for large files
" @see https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Keep cursor vertically centered
:set scrolloff=999

" Helper function to delete empty lines
" @see https://stackoverflow.com/a/706078
function! DeleteEmptyLines() abort
  execute 'g/^\s*$/d'
endfunction
command! -nargs=0 RemoveEmptyLines call DeleteEmptyLines()

" netrw
" Open preview in vertical split
let g:netrw_preview = 1
let g:netrw_alto = 0

" Line wrapping goodness
" @see https://vim.works/2019/03/16/wrapping-text-in-vim/
set whichwrap+=<,>,h,l
set colorcolumn=80
