" novum.vim -- A dark colorscheme, with a little monochrome syntax highlighting

highlight clear
let colors_name = 'novum'
let s:editingthisfile = expand('%:p') == expand('<sfile>:p')

if s:editingthisfile
	nnoremap <buffer> ( <c-x>:try <bar> execute getline('.') <bar> catch <bar> undo <bar> endtry<cr>
	nnoremap <buffer> ) <c-a>:try <bar> execute getline('.') <bar> catch <bar> undo <bar> endtry<cr>
endif

" 256 xterm color palette
let s:rgb = [
\ '#000000', '#c00000', '#008000', '#808000', '#000080', '#800080', '#008080', '#c0c0c0',
\ '#808080', '#ff0000', '#00ff00', '#ffff00', '#0000ff', '#ff00ff', '#00ffff', '#ffffff',
\ '#000000', '#00005f', '#000087', '#0000af', '#0000d7', '#0000ff', '#005f00', '#005f5f',
\ '#005f87', '#005faf', '#005fd7', '#005fff', '#008700', '#00875f', '#008787', '#0087af',
\ '#0087d7', '#0087ff', '#00af00', '#00af5f', '#00af87', '#00afaf', '#00afd7', '#00afff',
\ '#00d700', '#00d75f', '#00d787', '#00d7af', '#00d7d7', '#00d7ff', '#00ff00', '#00ff5f',
\ '#00ff87', '#00ffaf', '#00ffd7', '#00ffff', '#5f0000', '#5f005f', '#5f0087', '#5f00af',
\ '#5f00d7', '#5f00ff', '#5f5f00', '#5f5f5f', '#5f5f87', '#5f5faf', '#5f5fd7', '#5f5fff',
\ '#5f8700', '#5f875f', '#5f8787', '#5f87af', '#5f87d7', '#5f87ff', '#5faf00', '#5faf5f',
\ '#5faf87', '#5fafaf', '#5fafd7', '#5fafff', '#5fd700', '#5fd75f', '#5fd787', '#5fd7af',
\ '#5fd7d7', '#5fd7ff', '#5fff00', '#5fff5f', '#5fff87', '#5fffaf', '#5fffd7', '#5fffff',
\ '#870000', '#87005f', '#870087', '#8700af', '#8700d7', '#8700ff', '#875f00', '#875f5f',
\ '#875f87', '#875faf', '#875fd7', '#875fff', '#878700', '#87875f', '#878787', '#8787af',
\ '#8787d7', '#8787ff', '#87af00', '#87af5f', '#87af87', '#87afaf', '#87afd7', '#87afff',
\ '#87d700', '#87d75f', '#87d787', '#87d7af', '#87d7d7', '#87d7ff', '#87ff00', '#87ff5f',
\ '#87ff87', '#87ffaf', '#87ffd7', '#87ffff', '#af0000', '#af005f', '#af0087', '#af00af',
\ '#af00d7', '#af00ff', '#af5f00', '#af5f5f', '#af5f87', '#af5faf', '#af5fd7', '#af5fff',
\ '#af8700', '#af875f', '#af8787', '#af87af', '#af87d7', '#af87ff', '#afaf00', '#afaf5f',
\ '#afaf87', '#afafaf', '#afafd7', '#afafff', '#afd700', '#afd75f', '#afd787', '#afd7af',
\ '#afd7d7', '#afd7ff', '#afff00', '#afff5f', '#afff87', '#afffaf', '#afffd7', '#afffff',
\ '#d70000', '#d7005f', '#d70087', '#d700af', '#d700d7', '#d700ff', '#d75f00', '#d75f5f',
\ '#d75f87', '#d75faf', '#d75fd7', '#d75fff', '#d78700', '#d7875f', '#d78787', '#d787af',
\ '#d787d7', '#d787ff', '#d7af00', '#d7af5f', '#d7af87', '#d7afaf', '#d7afd7', '#d7afff',
\ '#d7d700', '#d7d75f', '#d7d787', '#d7d7af', '#d7d7d7', '#d7d7ff', '#d7ff00', '#d7ff5f',
\ '#d7ff87', '#d7ffaf', '#d7ffd7', '#d7ffff', '#ff0000', '#ff005f', '#ff0087', '#ff00af',
\ '#ff00d7', '#ff00ff', '#ff5f00', '#ff5f5f', '#ff5f87', '#ff5faf', '#ff5fd7', '#ff5fff',
\ '#ff8700', '#ff875f', '#ff8787', '#ff87af', '#ff87d7', '#ff87ff', '#ffaf00', '#ffaf5f',
\ '#ffaf87', '#ffafaf', '#ffafd7', '#ffafff', '#ffd700', '#ffd75f', '#ffd787', '#ffd7af',
\ '#ffd7d7', '#ffd7ff', '#ffff00', '#ffff5f', '#ffff87', '#ffffaf', '#ffffd7', '#ffffff',
\ '#080808', '#121212', '#1c1c1c', '#262626', '#303030', '#3a3a3a', '#444444', '#4e4e4e',
\ '#585858', '#626262', '#6c6c6c', '#767676', '#808080', '#8a8a8a', '#949494', '#9e9e9e',
\ '#a8a8a8', '#b2b2b2', '#bcbcbc', '#c6c6c6', '#d0d0d0', '#dadada', '#e4e4e4', '#eeeeee'
\ ]

function! s:highlight(grp, fg, bg, attr)
    let rgb_fg = a:fg =~# '^\d\+$' ? s:rgb[a:fg] : a:fg
    let rgb_bg = a:bg =~# '^\d\+$' ? s:rgb[a:bg] : a:bg
    exec 'hi! '.a:grp.' ctermfg='.a:fg.' ctermbg='.a:bg.' cterm='.a:attr
    exec 'hi! ' . a:grp . ' guifg=' . rgb_fg . ' guibg=' . rgb_bg . ' gui=' . a:attr
endfunction

command! -buffer -bar -nargs=+ Hi call s:highlight(<f-args>)

" Link many groups in one go.

function! s:linkto(to,...)
    for from in a:000
        execute 'highlight! link ' . from . ' ' . a:to
    endfor
endfunction

command! -buffer -nargs=+ Linkto call s:linkto(<f-args>)

set background=dark

" Functional groups
Hi normal           250 234 NONE
Hi lightemphasis    fg  bg  underline
Hi underline         NONE NONE underline
Hi emphasis         252 bg  bold
Hi deemphasis       240 bg  NONE
Hi lowvis           240 bg  NONE
Hi extralowvis      237 bg  NONE
Hi alert            203 bg  NONE
Hi highlightedtext  190 bg  NONE
Hi highlightedline  fg  235 NONE
Hi selection        252 241 NONE
Hi activetext       bg  252 NONE
Hi inactivetext     59  235 NONE
Hi colorful         71  bg  NONE
Hi activeui         71  235 NONE
Hi inactiveui       59  235 NONE
Hi altemphasis      76  bg  NONE
Hi altnormal        28  bg  NONE
Hi altdeemphasis    66  bg  NONE
Hi altlowvis        65  bg  NONE
Hi altcontrast      35  bg  bold

" Some special cases.
Hi pmenu            252 237 NONE
Hi pmenusbar        fg  238 NONE
Hi pmenuthumb       fg  243 NONE
Hi wildmenu         253 235 bold
Hi folded           245  235 NONE

" :h highlight-groups

Linkto normal           cursorlinenr diffchange modemsg moremsg question
Linkto lowvis           conceal diffdelete endofbuffer ignore foldcolumn
                        \ linenr nontext signcolumn
Linkto altlowvis        String
Linkto emphasis         directory title specialkey warningmsg
Linkto alert            errormsg
Linkto lightemphasis    matchparen
Linkto highlightedline  colorcolumn cursorcolumn cursorline
Linkto activetext       cursor cursorim incsearch pmenusel
Linkto highlightedtext  diffadd difftext search
Linkto activeui         StatusLine statuslineterm tablinesel
Linkto inactiveui       statuslinenc statuslinetermnc tabline tablinefill
Linkto extralowvis      vertsplit
Linkto selection        visual visualnos

" syntax -- :h group-name

" Ensure default linkage
Linkto constant         character number boolean float
Linkto identifier       function
Linkto statement        conditional repeat label exception
Linkto preproc          include define macro precondit
Linkto type             storageclass structure typedef
Linkto special          specialchar tag delimiter specialcomment debug

" Code: monochrome highlighting
Linkto normal           constant identifier preproc type special
Linkto alert            error
Linkto lightemphasis    todo
Linkto deemphasis       comment preproc
Linkto altdeemphasis    type
Linkto normal           statement

" Linkto emphasis         htmltag htmlendtag htmltagname htmlspecialtagname
Linkto contrast         htmlarg
Linkto altlowvis        htmlstring htmlvalue
Linkto emphasis         operator keyword
Linkto lowvis           htmcomment htmlcommentpart
Linkto diffconstant     diffonly diffidentical diffdiffer diffbdiffer diffisa
                        \ diffnoeol diffcommon
Linkto lowvis           diffcomment
Linkto deemphasis       diffremoved
Linkto emphasis         diffchanged diffadded difffile
Linkto emphasis      difffile
Linkto deemphasis    diffconstant diffindexline diffsubname diffline
Linkto emphasis         helphypertextjump helpcommand helpoption
Linkto deemphasis       helphypertextentry helpexample

Linkto underline    MatchWordCur MatchWord

if !s:editingthisfile
    delcom Linkto
    delcom Hi
endif

