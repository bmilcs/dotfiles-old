let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +5 bm/vim/.vimrc
badd +2 .vim/rc/0-core.vim
badd +1 bm/txt/vim.md
argglobal
%argdel
$argadd bm/vim/.vimrc
edit .vim/rc/0-core.vim
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 122 + 115) / 230)
exe '2resize ' . ((&lines * 40 + 41) / 83)
exe 'vert 2resize ' . ((&columns * 107 + 115) / 230)
exe '3resize ' . ((&lines * 40 + 41) / 83)
exe 'vert 3resize ' . ((&columns * 107 + 115) / 230)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 53 - ((49 * winheight(0) + 40) / 81)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
53
normal! 0
wincmd w
argglobal
if bufexists("bm/txt/vim.md") | buffer bm/txt/vim.md | else | edit bm/txt/vim.md | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 02|
wincmd w
argglobal
if bufexists("bm/vim/.vimrc") | buffer bm/vim/.vimrc | else | edit bm/vim/.vimrc | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 11 - ((7 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11
normal! 0
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 122 + 115) / 230)
exe '2resize ' . ((&lines * 40 + 41) / 83)
exe 'vert 2resize ' . ((&columns * 107 + 115) / 230)
exe '3resize ' . ((&lines * 40 + 41) / 83)
exe 'vert 3resize ' . ((&columns * 107 + 115) / 230)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
