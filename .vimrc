set nocompatible              " be iMproved, required
set hlsearch                  " set Search content highlight
set pastetoggle=<F2>          "设置粘贴模式不自动换行
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'Valloric/YouCompleteMe'
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let mapleader = "\<Space>"
set number
set relativenumber
set ts=4
set encoding=utf-8
set smartindent  
set shiftwidth=4  
set expandtab  

syntax enable
set background=dark
colorscheme solarized

set guifont=Consolas:h12
set guifontwide=Microsoft/YaHei:h12

let NERDTreeWinPos='left'
let NERDTreeWinSize=30
map <Leader>e :NERDTreeToggle<CR>

set laststatus=2
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

nmap <Leader>tt :TagbarToggle<CR>        "快捷键设置
let g:tagbar_ctags_bin='ctags'            "ctags程序的路径
let g:tagbar_width=30                    "窗口宽度的设置
nmap <Leader>tb :Tagbar<CR>
autocmd BufReadPost *.php,*.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen() "如果是c语言的程序的话，tagbar自动开启

"YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR> 
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR> 
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR> 
let g:ycm_cache_omnifunc=0  
let g:ycm_seed_identifiers_with_syntax = 1  
"nmap <F4> :YcmDiags<CR>"

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
"inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function CloseBracket()
    if match(getline(line('.') + 1), '\s*}') < 0
        return "\<CR>}"
    else
        return "\<Esc>j0f}a"
    endif
endf

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        return a:char
    elseif line[col - 1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Esc>i"
    endif
endf

"=================================================设置自动创建作者,更新时间等信息====================================================="
map <F4> ms:call AddAuthor()<cr>'s  
  
function AddAuthor()  
        let n=1  
        while n < 5  
                let line = getline(n)  
                if line =~'^\s*\*\s*\S*Last\s*modified\s*:\s*\S*.*$'  
                        call UpdateTitle()  
                        return  
                endif  
                let n = n + 1  
        endwhile  
        call AddTitle()  
endfunction  
  
function UpdateTitle()  
        normal m'  
        execute '/* Last modified\s*:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'  
        normal "  
        normal mk  
        execute '/* Filename\s*:/s@:.*$@\=": ".expand("%:t")@'  
        execute "noh"  
        normal 'k  
        echohl WarningMsg | echo "Successful in updating the copy right." | echohl None  
endfunction  
  
function AddTitle()  
        call append(0,"/**********************************************************")  
        call append(1," * Author        : gaohao")  
        call append(2," * Email         : denuth@163.com")  
        call append(3," * Last modified : ".strftime("%Y-%m-%d %H:%M"))  
        call append(4," * Filename      : ".expand("%:t"))  
        call append(5," * Description   : ")  
        call append(6," * *******************************************************/")  
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None  
endfunction  
