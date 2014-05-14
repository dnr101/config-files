if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif


colorscheme koehler

set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set mouse=a
set ls=2
set lines=48 columns=128
nmap <silent> ,ev :e $MYVIMRC
nmap <silent> ,sv :so $MYVIMRC

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
"  syntax on
"  set hlsearch
"endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

if has("autocmd")
    augroup content
        autocmd BufNewFile *.py
                    \ 0put = '#!/usr/bin/python'|
                    \ 1put = '#Filename: '.expand('<afile>')|
                    \ norm gg19jf
       autocmd Filetype html,shtml,xml,xsl source ~/.vim/scripts/closetag.vim 
    augroup END
endif

if has ("autocmd")
    augroup content    
         autocmd BufNewFile *.java
                    \ 0put = 'public class '.expand('<afile>:t:r').expand(' {')|
                    \ 2put = '}'|
                    \ 1put = '    '|   
    augroup END
endif

if has ("autocmd")
    autocmd Filetype python,perl,ruby call PyComment()
    autocmd Filetype javascript,cpp,c,java,php,cs call CJComment()
endif

if has ("autocmd")
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif

let g:pydiction_location = '~/.vim/after/ftplugin/pydiction/complete-dict'

setlocal completefunc=javacomplete#CompleteParamsInfo 
inoremap <Nul> <C-x><C-o>
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P> 
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P> 

syntax on
filetype indent on
filetype plugin on

set et
set sw=4
set background=dark
set softtabstop=4

function! Mouse()
    if &mouse == 'a'
        set mouse=
        echo "Mouse off..."
    else
        set mouse=a
        echo "Mouse on..."
    endif
endfunction

function! PyComment()
    map <S-F2> :s/^#/<CR>:noh<CR>
    map <F2> :s/^/#<CR>:noh<CR>
endfunction

function! CJComment()
    map <S-F2> :s/^\/\///<CR>:noh<CR>
    map <F2> :s/^/\/\//<CR>:noh<CR>
endfunction

map <F4>> :w\|!./%<cr>
map <F6> :w\|!javac %<CR>:!java %< <CR>
map <F11> :w\|!python %<CR>
map <S-F11> :w\|!ipython -i %<CR>
"map <F7> :!java %< <CR>
"map <F8> :w\|!make <CR>: !./%< <CR>
"map <F9> :!sudo rm %<.class<CR>
"map <F10> :w\|!make clean <CR> 
map <F12> :let &background = ( &background == "dark"? "light" : "dark" )<CR> 
map <S-F12> :call Mouse()<CR>
map <TAB> >>
map <S-TAB> <<
vmap <TAB> >gv
vmap <S-TAB> <gv
map <F9> :tabn<CR>
map <S-F9> :tabp<CR>
