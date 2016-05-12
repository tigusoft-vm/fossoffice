:syntax on

":set autoindent
:set smartindent

:set hlsearch

""" tabs

:set noexpandtab
:set copyindent
":set preserveindent

:set smarttab

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
:set softtabstop=0

" size of an "indent"
:set shiftwidth=2

" size of a hard tabstop
:set tabstop=2

:inoremap ` <C-n>

:inoremap <F2> <c-o>:w<CR>
:noremap <F2> <Esc>:w<CR>

:inoremap <F3> <c-o>:cp<CR>
:noremap <F3> <Esc>:cp<CR>
:inoremap <F4> <c-o>:cn<CR>
:noremap <F4> <Esc>:cn<CR>

:inoremap <F6> <c-o>:bp<CR>
 :noremap <F6> <Esc>:bp<CR>
:inoremap <F5> <c-o>:bn<CR>
 :noremap <F5> <Esc>:bn<CR>

:inoremap <F9> <C-\><C-O>:w<CR><C-\><C-O>:!clear<CR><C-\><C-O>:make -j 6 run<CR>
:noremap <F9> :w<CR>:!clear<CR>:make run<CR>

:inoremap <F10> <c-o>:set paste<CR>
:noremap <F10> <Esc>:set paste<CR>
:inoremap <s-F10> <c-o>:set nopaste<CR>
:noremap <s-F10> <Esc>:set nopaste<CR>

:inoremap <s-TAB> <c-o>:wincmd w<CR>
 :noremap <s-TAB> <Esc>:wincmd w<CR>

set viminfo='20,\"100000

" Tab navigation like Firefox.
"nnoremap <C-S-tab> :tabprevious<CR>
"nnoremap <C-tab>   :tabnext<CR>
"nnoremap <C-t>     :tabnew<CR>
"inoremap <C-S-tab> <Esc>:tabprevious<CR>i
"inoremap <C-tab>   <Esc>:tabnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR>

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=999 columns=999
else
  " This is console Vim.
  "if exists("+lines")
  "  set lines=50
  "endif
  "if exists("+columns")
  "  set columns=100
  "endif
endif



" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns


" collumn margin

"highlight ColorColumn ctermbg=magenta "set to whatever you like
"call matchadd('ColorColumn', '\%81v', 100) "set column nr

"let &colorcolumn=join(range(81,999),",")
"let &colorcolumn="80,".join(range(400,999),",")

highlight ColorColumn ctermbg=gray
set colorcolumn=130


" show current row

set cursorline
"hi CursorLine term=bold cterm=bold guibg=Grey40

"hi CursorLine  term=underline cterm=underline
"hi CursorLine  term=bold cterm=bold ctermbg=lightgrey
hi CursorLine  cterm=NONE term=NONE  ctermbg=darkblue


" for showmars plugin
let g:showmarks_enable=1
let g:showmarks_include=".mabcdefghijklnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

hi ShowMarksHLl ctermbg=yellow
hi ShowMarksHLu ctermbg=green
hi ShowMarksHLm ctermbg=magenta

"                     ShowMarksHLl - For marks a-z
"                     ShowMarksHLu - For marks A-Z
"                     ShowMarksHLo - For all other marks
"                     ShowMarksHLm - For multiple marks on the same line.
"                                    (Highest precendece mark is shown)



" trailing spaces


:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+\%#\@<!$/








