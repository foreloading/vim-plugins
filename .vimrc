""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: foreloading 
" Email: foreloading@gmail.com
"
" Version: 1.0 - 29/03/12 17:28
"
" Sections:
"	-> General
"	-> User interface
"	-> Colors and Fonts
"	-> Text & tab & indent
"	-> Visual mode related
"	-> Command mode related
"	-> Moving around, tabs and buffers
"	-> Statusline
"	-> Parenthesis/bracket expanding
"	-> General Abbrevs
"	-> Editing mapping
"   -> Cope
"	-> Plugins
"	    ->Pathogen
"	    ->Taglist
"	    ->neocomplcache-snippets-complete
"	    ->neocomplcache
"	    ->NERDTree
"	    ->winmanager
"       ->bufexplorer
"
"
" Plugins_download_links:
"	> https://github.com/paulnicholson/vim-pathogen
"	> https://github.com/vim-scripts/taglist.vim    
"	> https://github.com/Shougo/neocomplcache-snippets-complete
"	> https://github.com/scrooloose/nerdtree    
"	> http://www.vim.org/scripts/script.php?script_id=95 
"	> https://github.com/vim-scripts/winmanager.git 
"	> https://github.com/corntrace/bufexplorer.git  
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
"	====>  General 
""""""""""""""""""""""""""""""""""""""""""""""""""
set history=800    	 " sets lines of history to remember
filetype on	         " enable filetype check
filetype plugin on   " enable filetype plugin
filetype indent on 	 " enable indent
set autoread		 " auto read when a file is changed from the outside

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file 
let	mapleader = ","
let	g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc

" When vimrc isfname edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc	


""""""""""""""""""""""""""""""""""""""""""""""""""
"	===> user interface
""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7	"set 7 lines to the curors - when moving vertical..
set wildmenu	"turn on wild menu
set ruler	"show current position
set cmdheight=2	"the commandbar height
set hid	  "changed buffer-without saving

"set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase	"ignore case when searching
set smartcase

set hlsearch	"highlight search things
set incsearch	"make search act like search in	modern browsers
set nolazyredraw	"don't redraw while executing macros

set magic	"set magic on, for	regular expressions

set showmatch	"show matching bracets when text indicator isfname over them
set mat=2		"how many tenths of a second to blink


""""""""""""""""""""""""
" 一键编译/运行，F5编译，F6执行，支持C/C++/Java/Python
" """"""""""""""""""""""""
func! CompileGcc()
    exec "w"
    let compilecmd="!gcc "
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpicc "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif
    
    exec compilecmd." % ".compileflag
endfunc

func! CompileGpp()
    exec "w"
    let compilecmd="!g++ "
    let compileflag="-o %< "
    if search("mpi\.h") != 0
        let compilecmd = "!mpic++ "
    endif
    if search("glut\.h") != 0
        let compileflag .= " -lglut -lGLU -lGL "
    endif
    if search("cv\.h") != 0
        let compileflag .= " -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h") != 0
        let compileflag .= " -fopenmp "
    endif
    if search("math\.h") != 0
        let compileflag .= " -lm "
    endif

    exec compilecmd." % ".compileflag
endfunc

func! RunPython()
    exec "!python2 %"
endfunc

func! CompileJava()
    exec "!javac %"
endfunc

func! CompileCode()
    exec "w"
    if &filetype == "cpp"
        exec "call CompileGpp()"
    elseif &filetype == "c"
        exec "call CompileGcc()"
    elseif &filetype == "python"
        exec "call RunPython()"
    elseif &filetype == "java"
        exec "call CompileJava()"
    endif
endfunc

func! RunResult()
    exec "w"
    if search("mpi\.h") != 0
        exec "!mpirun -np 4 ./%<"
    elseif &filetype == "cpp"
        exec "! ./%<"
    elseif &filetype == "c"
       exec "! ./%<"
    elseif &filetype == "python"
       exec "call RunPython"
    elseif &filetype == "java"
       exec "!java %<"
    endif
endfunc
map <F5> :call CompileCode()<CR>
imap <F5> <ESC>:call CompileCode()<CR>
vmap <F5> <ESC>:call CompileCode()<CR>
map <F6> :call RunResult()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
"	===> Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable	"enable syntax hl
set number	    "set lines number	
colorscheme darkblue    " colorscheme of terminal 
syntax on       " syntax check
set	hls	        " highlight

""""""""""""""""""""""""""""""""""""""""""""""""""
"   ===> encoding
""""""""""""""""""""""""""""""""""""""""""""""""""
let &termencoding=&encoding "&tenc=&enc 
"set fileencodings=utf-8,gbk,big5,ucs-bom,cp936
"set fenc=utf-8
"set termencoding=utf-8
"set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,big5,cp936,ucs-bom
" consle乱码
"language message zh_CN.utf-8
"language message zh_CN.GKB
"set ambiwidth=double
"set encoding=utf-8
"set termencoding=utf-8
"set fileencodings=utf-8,chinese,latin-1,gbk,gb2312,big5,ucs-bom
"if has("win32")
"    set fileencoding=chinese
"else
"    set fileencoding=utf-8
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""
"	===> Text & tab & indent related
""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set autoindent	"auto indent	
set cindent		"C indent	
set shiftwidth=4
set incsearch
set	wrap	"wrap lines	

"""""""""""""""""""""""""""""""""""""""""""""""""
"   ===> ctags
"""""""""""""""""""""""""""""""""""""""""""""""""
"按下F12即可生成tag
map <F12> :!ctags -R <CR><CR> 
set tags=tags	"ctags
set autochdir	"ctags
set lbr
set tw=500

"""""""""""""""""""""""""""""""""""""""""""""""""
"   ===> cscope
"""""""""""""""""""""""""""""""""""""""""""""""""
" 按下F7即可生成cscope.out
map <F7> :!cscope -Rbkq <CR><CR>    
if has("cscope") && filereadable("/usr/bin/cscope")
    set csprg=/usr/bin/cscope " 指定用来执行cscope的命令 
    set csto=1                " 先搜索tags标签,再搜索cscope数据库
    set cst                   " 使用|:cstag|(:cs find g),而不是缺省的:tag
    set nocsverb              " 不显示添加数据库是否成功
" add any database in current directory
if filereadable("cscope.out")
    cs add cscope.out       " 添加cscope数据库文件
elseif filereadable("../cscope.out")
    cs add ../cscope.out 
elseif filereadable("../../cscope.out")
    cs add ../../cscope.out
elseif filereadable("../../../cscope.out")
    cs add ../../../cscope.out
endif
set csverb      " 显示添加成功与否
endif

" Use both cscope and ctags
set cscopetag

" Show msg when cscope db added
set cscopeverbose

" Use tags for definition search first
set cscopetagorder=1

" Use quickfix window to show cscope results
set cscopequickfix=s-,c-,d-,i-,t-,e-

" Cscope mappings
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""
"	===> Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""
" In visual mode when you press * or # to search for	the current section
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
	    let l:saved_reg = @"
	    execute "normal! vgvy"

	    let l:pattern = escape(@", '\\/.*$^~[]')
	    let l:pattern = substitute(l:pattern, "\n$", "", "")

	    if a:direction == 'b'
	        execute "normal ?" . l:pattern . "^M"
	    elseif a:direction == 'gv'
	        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
        elseif a:direction == 'f'
            execute "normal /" . l:pattern . "^M"
       endif

	   let @/ = l:pattern
       let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ===> Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

func! Cwd()
   let cwd = getcwd()
   return "e " . cwd 
endfunc

func! DeleteTillSlash()
    let g:cmd = getcmdline()
    if MySys() == "linux" || MySys() == "mac"
	   let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
	else
	   let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
	endif

	if g:cmd == g:cmd_edited
		if MySys() == "linux" || MySys() == "mac"			
			let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
		else
			let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
		endif
	endif
	return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
	return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ===> Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

   	if buflisted(l:alternateBufNum)
	buffer #
    else
      bnext
    endif

    if bufnr("%") == l:currentBufNum
       new
    endif

    if buflisted(l:currentBufNum)
       execute("bdelete! ".l:currentBufNum)
     endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry

""""""""""""""""""""""""""""""
" ===> Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ CWD:\ %r%{CurDir()}%h\ \ Line:\ %l/%L:%c\ \ Percent:\ %p%%  


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
		return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ===> Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ===> General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ===> Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
	exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ===> Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>



"""""""""""""""""""""""""""""""""""""
""""""""""""    Plugins   """""""""""
"""""""""""""""""""""""""""""""""""""

"====================================
"   ===> Plugins - Pathogen
"====================================

"call pathogen#runtime_append_all_bundles()
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
Helptags

"=====================================================================
"	===> Plugins - Taglist
"=====================================================================
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Use_Left_Window=1
let Tlist_Auto_Open=0
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
nnoremap <silent><F9> :TlistToggle<CR>  

"======================================================================
"	===>  Plugins neocomplcache-snippets-complete
"======================================================================

imap <silent><C-e> <Plug>(neocomplcache_snippets_expand)
smap <silent><C-e> <Plug>(neocomplcache_snippets_expand)
"imap <tab><C-e><Plug>(neocomplcache_snippets_expand)
"smap <tab><c-e><Plug>(neocomplcache_snippets_expand)
inoremap <expr><space> pumvisible()?neocomplcache#close_popup()."\<SPACE>":"\<SPACE>"

"======================================================================
" 	===> Plugins - neocomplcache
"======================================================================
"let g:acp_enableAtStartup=0" Disable AutoComplPop.
let g:neocomplcache_enable_at_startup=1 " Use neocomplcache.
let g:neocomplcache_enable_smart_case=1 "When a capital letter is included in input, neocomplcache do not ignore the upper- and lowercase.
let g:neocomplcache_enable_auto_select=1
let g:neocomplcache_enable_quick_match=1 "choose a candidate with a alphabet or number displayed beside a candidate after 鈥�-鈥�.
let g:neocomplcache_enable_underbar_completion=1 "match it with 鈥榩ublic_html鈥� when you input it with 鈥榩_h鈥�.
let g:neocomplcache_enable_camel_case_completion=1 " Use camel case completion.
let g:neocomplcache_min_syntax_length=2 "Set minimum syntax keyword length.
let g:neocomplcache_min_keyword_length=3 "length of keyword becoming the object of the completion at the minimum.
let g:neocomplcache_enable_camel_case_completion=1 "match it with ArgumentsException when you input it with AE.

set foldenable 
set foldmethod=syntax 
set foldcolumn=0 
setlocal foldlevel=1 
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> 
"key stock

"======================================================================
"	===>Plugins	- NERD Tree
"======================================================================
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeBookmarksFile=$VIM.'\Data\NerdBookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='right'
let NERDTreeWinSize=31
nnoremap <silent><F3> :NERDTreeToggle<CR>

let NERDSpaceDelims=1 
let NERDCompactSexyComs=1 

"======================================================================
"   ===>Plugins - winmanager
"======================================================================
"璁剧疆鐣岄潰鍒嗗壊
"let g:winManagerWindowLayout='TagList|FileExplorer,BufExplorer'
"let g:winManagerWindowLayout='TagList|NERDTree'
"璁剧疆winmanager鐨勫搴︼紝榛樿涓�25
"let g:winManagerWidth = 30
"瀹氫箟鎵撳紑鍏抽棴winmanager鎸夐敭
nmap <silent> <F8> :WMToggle<cr>

let g:AutoOpenWinManager=1
let g:NERDTree_title='NERD Tree'
let g:winManagerWindowLayout='NERDTree|TagList'

function! NERDTree_Start()
    exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
    return 1
endfunction
