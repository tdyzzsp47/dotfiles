set nocompatible
filetype off
filetype plugin indent off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" 導入したいプラグインを以下に列挙
" Plugin '[Github Author]/[Github repo]' の形式で記入

" 左端にgit diffのステータスを表示（@TODO: 追加以外の差分がなぜか表示されない）
Plugin 'airblade/vim-gitgutter'

Plugin 'nanotech/jellybeans.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'Townk/vim-autoclose'

Plugin 'bronson/vim-trailing-whitespace'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'tomtom/tcomment_vim'

Plugin 'Shougo/neocomplcache'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'w0rp/ale'
Plugin 'scrooloose/syntastic'
Plugin 'posva/vim-vue'
Plugin 'fatih/vim-go'
Plugin 'skanehira/preview-markdown.vim'
"
call vundle#end()


" setting
set nobackup "バックアップファイルを生成しない
set noswapfile " スワップファイルを生成しない
set backspace=indent,eol,start
set updatetime=250

" visual
set title " ウィンドウのタイトルバーにファイルのパス情報等を表示する
set number " 行番号を表示する
set cursorline " カーソルの行を目立たせる
set virtualedit=onemore " 行末の一文字先までカーソルを移動できる
set smartindent " 適切なインデントを入れる
set showmatch " ペア括弧を表示する
set laststatus=2 " ステータスラインを常に表示

" tab
set expandtab " タブの代わりに空白文字を挿入する
set tabstop=4 " タブ文字の表示幅
set shiftwidth=4 " Vimが挿入するインデントの幅

set whichwrap=b,s,h,l,<,>,[,] " カーソルを行頭、行末で止まらないようにする
set incsearch " 検索ワードの最初の文字を入力した時点で検索を開始する
set smartcase " 小文字のみで検索したときに大文字小文字を無視する
set hlsearch " 検索結果をハイライト表示する
set clipboard=unnamed " クリップボードと無名レジスタを連携

" ctl+tで新規タブ
nnoremap <silent><C-t> :tabnew<CR>
nnoremap <silent><C-i> gt

" ctl+oでターミナル画面
nnoremap <silent><C-o> :call TermOpen()<CR>

" 画面分割の幅操作
nnoremap <silent><C-l> <C-w>>
nnoremap <silent><C-h> <C-w><

" NERDTreeを開くためのマッピング
nnoremap <silent><C-e> :NERDTree<CR>
let g:nerdtree_tabs_open_on_console_startup=1 " 起動時に開く
let NERDTreeShowHidden = 1 " 「.」始まりのファイルも表示
" NERDTreeだけが残る場合はvimを終了
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 折り返し時に表示行単位で移動できるようにする
nnoremap j gj
nnoremap k gk

" 構文ごとに文字色を変化させる
syntax on

set t_Co=256 " 色を設定
colorscheme jellybeans


" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
"""""""""""""""""""""""""""""
" Unit.vimの設定
"""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"""""""""""""""""""""""""""""


" http://inari.hatenablog.com/entry/2014/05/05/231307
"""""""""""""""""""""""""""""
" 全角スペースの表示
"""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
"""""""""""""""""""""""""""""


" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
" let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
"
" if has('syntax')
"   augroup InsertHook
"     autocmd!
"     autocmd InsertEnter * call s:StatusLine('Enter')
"     autocmd InsertLeave * call s:StatusLine('Leave')
"   augroup END
" endif

" let s:slhlcmd = ''
" function! s:StatusLine(mode)
"   if a:mode == 'Enter'
"     silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"     silent exec g:hi_insert
"   else
"     highlight clear StatusLine
"     silent exec s:slhlcmd
"   endif
" endfunction
"
" function! s:GetHighlight(hi)
"   redir => hl
"   exec 'highlight '.a:hi
"   redir END
"   let hl = substitute(hl, '[\r\n]', '', 'g')
"   let hl = substitute(hl, 'xxx', '', '')
"   return hl
" endfunction
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" マウスでカーソル移動できる
""""""""""""""""""""""""""""""
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" ペーストするときだけ自動インデントしない
""""""""""""""""""""""""""""""
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
""""""""""""""""""""""""""""""

" function! Autopep8()
"     call Preserve(':silent %!autopep8 -')
" endfunction

" Shift + F で自動修正
" autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>
"

" 以下neocompleteの設定（補完機能）
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

set completeopt=menuone " 補完ウィンドウの設定

let g:rsenseUseOmniFunc = 1 " rsenseでの自動補完機能を有効化
" let g:rsenseHome = '/usr/local/lib/rsense-0.3'

let g:auto_ctags = 1 " auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
let g:neocomplcache_enable_smart_case = 1 " 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_underbar_completion = 1 " _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_camel_case_completion  =  1
let g:neocomplcache_enable_auto_select = 1 " 最初の補完候補を選択状態にする
let g:neocomplcache_max_list = 20 " ポップアップメニューで表示される候補の数
let g:neocomplcache_min_syntax_length = 3 " シンタックスをキャッシュするときの最小文字長

" 補完の設定
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'


" スニペットの設定
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"set snippet file dir
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/,~/.vim/snippets'


" lintの設定
""" Recommended settings
""" see https://github.com/scrooloose/syntastic#settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ターミナル関係の設定
function! TermOpen()
    " execute "tabnew"
    if empty(term_list())
        execute "vs"
        execute "wincmd w"
        execute "terminal ++curwin"
    else
        call win_gotoid(win_findbuf(term_list()[0])[0])
    endif
endfunction

"if neobundle#tap('vim-trailing-whitespace')
"    " uniteでスペースが表示されるので、設定でOFFにします。
"    let g:extra_whitespace_ignored_filetypes = ['unite']
"endif

filetype plugin indent on

