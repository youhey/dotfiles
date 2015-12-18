" @see http://vimwiki.net/?%27guioptions%27 guioptions

" Color scheme
" colorscheme molokai
colorscheme wombat
set background=dark

" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

set matchtime=3   " showmatchの表示時間
set showtabline=2 " 常にタブを表示
"set imdisable     " コマンドモードでIMEをオフ
set guioptions+=a " ビジュアルモードで選択した文字列をシステムのクリップボードに

" ツールバー／メニューバー非表示
set guioptions-=T guioptions-=m

" スクロールバー非表示
set guioptions-=r guioptions-=R guioptions-=l guioptions-=L guioptions-=b

" ステータスライン
set laststatus=2 "表示
set statusline=%t<%<%F>%m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l-%c[%p%%]
highlight StatusLine term=NONE cterm=NONE guifg=white guibg=NONE gui=bold
highlight StatusLineNC term=NONE cterm=NONE guifg=grey50 guibg=NONE
" highlight StatusLineNC cterm=reverse

" FONT
if has('win32')
  " for Windows
  " set guifont=MS_Gothic:h11:cSHIFTJIS
  " set guifontwide=MS_Gothic:h11:cSHIFTJIS
  set guifont=Migu_1M:h13:cSHIFTJIS
  set guifontwide=Migu_1M:h13:cSHIFTJIS
  set antialias " アンチエイリアスON
  set linespace=2 " 行間
  if has('kaoriya')
    set ambiwidth=auto " 一部のUCS文字の幅を自動計測して決める
  endif
elseif has('mac')
  " for Mac
  set guifont=Osaka－等幅:h14
  set guifontwide=Osaka－等幅:h14
  set antialias " アンチエイリアス
endif

" for Windows
if has('gui_macvim')
  " Window size
  set lines=52 columns=100

  set transparency=5

  map gw :macaction selectNextWindow:
  map gW :macaction selectPreviousWindow:

  " Fullscreen
  function! FullAndHideTab()
    set fuoptions=maxvert,maxhorz
    set invfullscreen
  
    set transparency=50

    if &showtabline==0
      set showtabline=2
      "set columns=columns
      "set lines=lines
      set fuoptions=lines,columns
      set transparency=30
    else
      set showtabline=0
    end
  endfunction
  nnoremap <silent><space>f :call FullAndHideTab()
endif

  " IME状態に応じたカーソル色を設定
  if has('multi_byte_ime')
    highlight Cursor guifg=#000d18 guibg=#8faf9f gui=bold
    highlight CursorIM guifg=NONE guibg=#ecbcdc
  end

" for Windows
if has('win32')
  nmap ; :

  " Window size
  set lines=64 columns=112

  set guioptions=-c " 簡単な質問をポップアップダイアログではなくコンソールに
end

if has('win32')
  gui
  set transparency=225
endif
