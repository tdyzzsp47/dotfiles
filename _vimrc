
nnoremap <silent><C-e> :NERDTree<CR>

" setting
set nobackup
set noswapfile

" visual
set number
set cursorline 
set virtualedit=onemore
set smartindent
set showmatch
set laststatus=2

" tab
set expandtab
set tabstop=4
set shiftwidth=4

"set encoding=utf-8
"set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
"set fileformats=unix,dos,mac

syntax on

" neobundle settings {{{
if has('vim_starting')
    set nocompatible
    " neobundle をインストールしていない場合は自動インストール
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install neobundle..."
        " vim からコマンド呼び出しているだけ neobundle.vim のクローン
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
    " runtimepath の追加は必須
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'
" ↓こんな感じが基本の書き方
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Townk/vim-autoclose'

" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()
filetype plugin indent on
" どうせだから jellybeans カラースキーマを使ってみましょう
set t_Co=256
colorscheme jellybeans
