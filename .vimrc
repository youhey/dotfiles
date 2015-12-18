set encoding=utf-8
scriptencoding utf-8

" マルチバイトの記述のために先頭で「scriptencoding」を設定
" また、「scriptencoding」を設定するために、さらに前で「encoding」を設定

set nocompatible " vi非互換モード "

"#######################
" 備忘録
"#######################
"
" @see http://rbtnn.hateblo.jp/entry/2014/11/30/174749 アンチパターン
"
" <Bar>
"   :map コマンドで連続して実行するコマンドを区切るとき
"   マップの中では「|」の文字が使えないので替りに「<Bar>」を使用
" <Nop>
"   何もしないキーを定義
" <expr>
"   マップや短縮入力の定義で、引数を式として扱う
" <cword>
"   カーソル下の word に置き換えられる
" 
" 制御文字表
"     | ^@ | NUL | 00 |
"     | ^A | SOH | 01 |
"     | ^B | STX | 02 |
"     | ^C | ETX | 03 |
"     | ^D | EOT | 04 |
"     | ^E | ENQ | 05 |
"     | ^F | ACK | 06 |
"     | ^G | BEL | 07 |
"     | ^H | BS  | 08 |
"     | ^I | HT  | 09 |
"     | ^J | LF  | 0A |
"     | ^K | VT  | 0B |
"     | ^L | FF  | 0C |
"     | ^M | CR  | 0D |
"     | ^N | SO  | 0E |
"     | ^O | SI  | 0F |
"     | ^P | DLE | 10 |
"     | ^Q | DC1 | 11 |
"     | ^R | DC2 | 12 |
"     | ^S | DC3 | 13 |
"     | ^T | DC4 | 14 |
"     | ^U | NAK | 15 |
"     | ^V | SYN | 16 |
"     | ^W | ETB | 17 |
"     | ^X | CAN | 18 |
"     | ^Y | EM  | 19 |
"     | ^Z | SUB | 1A |
"     | ^[ | ESC | 1B |
"     | ^\ | FS  | 1C |
"     | ^] | GS  | 1D |
"     | ^^ | RS  | 1E |
"     | ^_ | US  | 1F |
"     | ^? | DEL | 7F |

"#######################
" 表示系
"#######################
syntax on        " 構文のシンタックスハイライト "
set number       " 行番号表示 "
set showmode     " モード表示 "
set title        " 編集中のファイル名を表示 "
set ruler        " ルーラーの表示 "
set showcmd      " 入力中のコマンドをステータスに表示する "
set showmatch    " 括弧入力時の対応する括弧を表示 "
set laststatus=2 " ステータスラインを常に表示 "

" カーソル行にハイライト
set cursorline
hi clear CursorLine
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

"#######################
" プログラミングヘルプ系
"#######################
set smartindent                       " オートインデント "
set expandtab                         " タブの代わりに空白文字挿入 "
set ts=4 sw=4 sts=0                   " タブは半角4文字分のスペース "
set tabstop=4                         " ファイル内のTABが対応する空白の数 "
set shiftwidth=4                      " シフト移動幅 "
set autoindent                        " 新しい行のインデントを現在行と同じに "
set smarttab                          " 行頭の余白内でTabを打ち込むと、shiftwidthだけインデント "

" タブ文字、行末など不可視文字を表示する
" 不可視文字の表示フォーマット
"   eol: 改行
"   tab: TAB
"   extends: 右に省略した文字列あり
"   precedes: 左に省略した文字列あり
"   trail: 行末に続くスペース
"   nbsp: ノーブレークスペース
set list
"set listchars=eol:$,tab:>\ ,trail:\ ,extends:<,precedes:>
set listchars=eol:↲,tab:»\ ,trail:.,extends:«,precedes:»

" 全角スペースの可視化
syn sync fromstart
function! ActivateInvisibleIndicator()
  syntax match InvisibleJISX0208Space "　" display containedin=ALL
  highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
endfunction
augroup invisible
  autocmd! invisible
  autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
augroup END

"#######################
" 検索系
" @see http://haya14busa.com/vim_highlight_search/ 検索ハイライト
"#######################
set ignorecase  " 検索文字列が小文字の場合は大文字小文字を区別なく検索する "
set smartcase   " 検索文字列に大文字が含まれている場合は区別して検索する "
set wrapscan    " 検索時に最後まで行ったら最初に戻る "
set noincsearch " 検索文字列入力時に順次対象文字列にヒットさせない "
"set nohlsearch " 検索結果文字列の非ハイライト表示 "
set hlsearch    " 検索結果文字列をハイライト表示 "
set nowrapscan  " 検索をファイルの先頭へループしない "

"#######################
" カーソル位置を置換
"   s*：カーソル位置の単語を置換（:%s ;\<カーソル位置の単語\>）
"#######################
nnoremap s* <Nop>
vnoremap s* <Nop>
nnoremap <expr> s* ':%s ;\<' . expand('<cword>') . '\>;'
vnoremap <expr> s* ':s ;\<' . expand('<cword>') . '\>;'

" Escの2回押しでハイライト消去 "
nmap <ESC><ESC> :nohlsearch<CR><ESC>

"#######################
" インサートモード
"   Ctrl-[j][k][h][l] でカーソル移動 "
"   jj でインサートモードを抜ける "
"#######################
inoremap <silent> <C-j> <Down>
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-l> <Right>
inoremap <silent> jj <ESC>

" インサートモードでステータスラインのカラーを変更 "
" インサートモードを抜けたら ペーストモードを解除 "
augroup InsertHook
  autocmd! InsertHook
  autocmd InsertEnter * highlight StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow   cterm=none
  autocmd InsertLeave * highlight StatusLine guifg=DarkBlue guibg=DarkGray   gui=none ctermfg=Blue ctermbg=DarkGray cterm=none
  autocmd InsertLeave * set nopaste
augroup END

" インサートモードで<INSERT>打鍵したらペーストモード
set pastetoggle=<Insert>

"#######################
" TAB
"   tc:新しいタブを一番右に作る
"   tx:タブを閉じる
"   tn:次のタブに移動
"   tp:前のタブに移動
"   t1-t9:n番目のタブに移動
"   <del>Ctrl+t 次のタブ（like gt）</del>
"   <del>Ctrl+T 前のタブ（like gT）</del>
"   ※あまり使わないので Ctrl+t Ctrl+T は廃止
"   Tab: 次のタブに移動
"   Shift+Tab: 前のタブに移動
"#######################
nnoremap t <Nop>
nmap t [Tab]
noremap [Tab]c :tablast <Bar> tabnew<CR>
noremap [Tab]x :tabclose<CR>
noremap [Tab]n :tabnext<CR>
noremap [Tab]p :tabprevious<CR>
nnoremap [Tab]1 :tabnext 1<CR>
nnoremap [Tab]2 :tabnext 2<CR>
nnoremap [Tab]3 :tabnext 3<CR>
nnoremap [Tab]4 :tabnext 4<CR>
nnoremap [Tab]5 :tabnext 5<CR>
nnoremap [Tab]6 :tabnext 6<CR>
nnoremap [Tab]7 :tabnext 7<CR>
nnoremap [Tab]8 :tabnext 8<CR>
nnoremap [Tab]9 :tabnext 9<CR>
"nnoremap <C-n> :tabnext<CR>
"nnoremap <C-p> :tabprevious<CR>
nnoremap <Tab> <Nop>
nnoremap <S-Tab> <Nop>
noremap <Tab> :tabnext<CR>
noremap <S-Tab> :tabprevious<CR>

"#######################
" 画面分割
"   ss:横に分割（Like Ctrl-s s）
"   sv:縦に分割（Like Ctrl-s v）
"   sn:新しい画面で空ファイルの編集を開始（Like Ctrl-s n）
"   sq:画面を閉じる（Like Ctrl-s q）
"   s[j][k][h][l]: カーソルを画面間で移動（Like Ctrl-s [j][k][h][l]）
"   s[J][K][H][L]: 画面の位置を移動（Like Ctrl-s [J][K][H][L]）
"   Ctrl+Tab: 次の画面にカーソル移動
"   Ctrl+Shift+Tab: 前の画面にカーソル移動
"#######################
nnoremap s <Nop>
nmap s [Split]
noremap [Split]s :split<CR>
noremap [Split]v :vsplit<CR>
noremap [Split]n :new<CR>
noremap [Split]q :quit<CR>
noremap [Split]j :wincmd j<CR>
noremap [Split]k :wincmd k<CR>
noremap [Split]h :wincmd h<CR>
noremap [Split]l :wincmd l<CR>
noremap [Split]J :wincmd J<CR>
noremap [Split]K :wincmd K<CR>
noremap [Split]H :wincmd H<CR>
noremap [Split]L :wincmd L<CR>
nnoremap <C-Tab> <Nop>
nnoremap <C-S-Tab> <Nop>
noremap <C-Tab> :wincmd w<CR>
noremap <C-S-Tab> :wincmd W<CR>

"#######################
" 文字コード
"#######################
"set encoding=utf-8 " scriptencoding を設定するために先頭行で定義済みなので
set fileencoding=utf-8
set fileencodings=utf-8
if has('win32') && has('kaoriya')
    set ambiwidth=auto " 全角記号の幅を自動判定に
else
    set ambiwidth=double " 全角記号を半角幅から全角幅に
endif
" set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
" とかとか、もう今更の環境で要らないよね、って
"if has('iconv')
"    let s:enc_euc = 'euc-jp'
"    let s:enc_jis = 'iso-2022-jp'
"
"    if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"        let s:enc_euc = 'euc-jisx0213,euc-jp'
"        let s:enc_jis = 'iso-2022-jp-3'
"    endif
"
"    set fileencodings&
"    let &fileencodings = &fileencodings.','.s:enc_jis.',cp932,'.s:enc_euc
"
"    unlet s:enc_euc
"    unlet s:enc_jis
"endif
"if has('win32unix')
"    set termencoding=cp932
"elseif !has('macunix')
"    set termencoding=euc-jp
"endif
" あんまり改行コードの自動判定が必要そうな環境ないから
"set fileformats=dos,unix,mac

"#######################
" バックアップ
"#######################
set backupdir=$HOME/.vim/backup
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/

"#######################
" スワップ
"#######################
set directory=$HOME/.vim/swap " スワップファイル用のディレクトリ "

"#######################
" その他もろもろ
"#######################
set browsedir=buffer                               " ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定 "
set clipboard=unnamed                              " クリップボードを連携 "
set hidden                                         " 変更中のファイルでも、保存しないで他のファイルを表示 "
set incsearch                                      " インクリメンタルサーチを行う "
set whichwrap=b,s,h,l,<,>,[,]                      " カーソルを行頭、行末で止まらないようにする "
set shellslash                                     " Windowsでディレクトリパスの区切り文字に / を使えるようにする "
au BufNewFile,BufRead * set iminsert=0             " 日本語入力をリセット "
au BufNewFile,BufRead * set tabstop=4 shiftwidth=4 " タブ幅をリセット "

if 1

  "#######################
  " Neobundle
  "#######################

  "---------------------------
  " Start Neobundle Settings.
  "---------------------------
  " bundleで管理するディレクトリを指定 "
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  " Required:
  call neobundle#begin(expand('~/.vim/bundle/'))

  " neobundle自体をneobundleで管理 "
  NeoBundleFetch 'Shougo/neobundle.vim'

  " プラグイン"

  " NERDTree "
  NeoBundle 'scrooloose/nerdtree'
    " Ctrl+e is :NERDTree
    nnoremap <silent><C-e> :NERDTreeToggle<CR>

  " autoclose "
  NeoBundle 'Townk/vim-autoclose'

  " 入力補完 neocomplcache - neo-completion with cache "
  NeoBundle 'Shougo/neocomplcache'
    " AutoComplPop を無効に "
      let g:acp_enableAtStartup = 0
    " neocomplcache を有効に "
      let g:neocomplcache_enable_at_startup = 1

    " 大文字が入力されるまで大文字小文字を区別しない "
      let g:neocomplcache_enable_smart_case = 1
    " 自動で一番目の候補を選択、無効に "
      let g:neocomplcache_enable_auto_select = 0
    " キャメルケースの先頭大文字でワイルドカード補完、無効に "
      let g:neocomplcache_enable_camel_case_completion = 0
    " 先頭文字とアンダーバーでワイルドカード補完、無効に "
      let g:neocomplcache_enable_underbar_completion = 0
    " シンタックスをキャッシュする最小文字数 "
      let g:neocomplcache_min_syntax_length = 3
    " 自動的にロックするバッファ名のパターン、ku.vim "
      let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    " Set manual completion length.
    "let g:neocomplcache_manual_completion_start_length = 0

    " Define dictionary.
    "let g:neocomplcache_dictionary_filetype_lists = {
    "    \ 'default' : '',
    "    \ 'vimshell' : $HOME.'/.vimshell_hist',
    "    \ 'scheme' : $HOME.'/.gosh_completions', 
    "    \ 'scala' : $DOTVIM.'/dict/scala.dict', 
    "    \ 'ruby' : $DOTVIM.'/dict/ruby.dict'
    "    \ }
    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : ''
        \ }

    " Plugin key-mappings.
    "inoremap <expr><C-g>     neocomplcache#undo_completion()
    "inoremap <expr><C-l>     neocomplcache#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    "inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    "function! s:my_cr_function()
    "  return neocomplcache#smart_close_popup() . "\<CR>"
    "endfunction
    " <TAB>: completion.
    "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    "inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    "inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    "inoremap <expr><C-y>  neocomplcache#close_popup()
    "inoremap <expr><C-e>  neocomplcache#cancel_popup()

    " Define keyword.
    "if !exists('g:neocomplcache_keyword_patterns')
    "    let g:neocomplcache_keyword_patterns = {}
    "endif
    "let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " タグ補完 "
    " キャッシュが増えて重くなりそうなので有効にしてない "
    "augroup SetTagsFile
    "  autocmd! SetTagsFile
    "  autocmd FileType php set tags=$HOME/.vim/tags/php.tags
    "augroup END
    "if !exists('g:neocomplcache_member_prefix_patterns')
    "  let g:neocomplcache_member_prefix_patterns = {}
    "endif
    "let g:neocomplcache_member_prefix_patterns['php'] = '->\|::'

    " スニペット補完 "
    let g:neocomplcache_snippets_disable_runtime_snippets = 1
    let g:neocomplcache_snippets_dir = $HOME.'/snippets'

    " オムニ補完 "
    augroup SetOmniCompletionSetting
      autocmd! SetOmniCompletionSetting
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
      "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
      "autocmd FileType eruby,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      "autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    augroup END
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    if !exists('g:neocomplcache_omni_functions')
      let g:neocomplcache_omni_functions = {}
    endif
    let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'

  " Emmet "
  NeoBundle 'mattn/emmet-vim'

  " quickrun "
  NeoBundle 'thinca/vim-quickrun'
    let g:quickrun_config = {}
    let g:quickrun_config['*'] = {'split': ''}
    let g:quickrun_config['babel'] = {
      \ 'cmdopt': '--stage 1',
      \ 'exec': "babel %o %s | node"
      \ }

  " grep.vim "
  NeoBundle 'grep.vim'

  " syntastic "
  NeoBundle 'scrooloose/syntastic'
    let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['php', 'javascript', 'json'],
      \ 'passive_filetypes': ['html']
      \}

    let g:syntastic_auto_loc_list = 1

    "let g:syntastic_javascript_checker = 'jshint'
    "let g:syntastic_javascript_checker = 'gjslint'
    "let g:syntastic_javascript_checkers = ['jshint']
    "let g:syntastic_javascript_checkers = ['gjslint']
    "let g:syntastic_javascript_checkers = ['jshint', 'gjslint']
    "let g:syntastic_javascript_checkers = ['eslint', 'gjslint']
    let g:syntastic_javascript_checkers = ['eslint']

    "let g:syntastic_php_checker = 'phpcs'
    "let g:syntastic_php_checkers = ['php', 'phpcs']
    let g:syntastic_php_checkers = ['phpcs']
    "let g:syntastic_phpcs_conf = '--standard=PSR2'
    let g:syntastic_php_phpcs_args = '--standard=PSR2'

    " ファイルオープン時にはチェックをしない "
      let g:syntastic_check_on_open = 0

    " ファイル保存時にはチェックを実施 "
      let g:syntastic_check_on_save = 1

    let g:syntastic_enable_signs = 1

    if has('win32')
      let g:syntastic_error_symbol = '✗'
      let g:syntastic_warning_symbol = '⚠'
    elseif has('mac')
      let g:syntastic_error_symbol = '✗'
      let g:syntastic_warning_symbol = '⚠'
    else
      let g:syntastic_error_symbol = '>>'
      let g:syntastic_warning_symbol = '->'
    endif

  " JavaScriptシンタックス "
  " NeoBundle 'JavaScript-syntax'
  " NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

  " node.js "
  NeoBundle 'moll/vim-node'
  NeoBundle 'myhere/vim-nodejs-complete'
    let g:node_usejscomplete = 1
  "NeoBundle 'mattn/jscomplete-vim'
  "NeoBundle 'guileen/vim-node-dict'
  "  au FileType javascript set dictionary+=$HOME/.vim/bundle/vim-node-dict/dict/node.dict

  " vim-ref "
  NeoBundle 'thinca/vim-ref'

  call neobundle#end()

  " Required:
  filetype plugin indent on

  " 未インストールのプラグインがあればインストールするかを確認
  NeoBundleCheck

  "-------------------------
  " End Neobundle Settings.
  "-------------------------

endif
