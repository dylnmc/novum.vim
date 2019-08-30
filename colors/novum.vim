" novum.vim -- A dark colorscheme, with a little monochrome syntax highlighting

highlight clear
let colors_name = 'novum'
let s:editingthisfile = expand('%:p') == expand('<sfile>:p')

if s:editingthisfile
	nnoremap <buffer> ( <c-x>:try<bar>execute getline('.')<bar>catch<bar>undo<bar>endtry<cr>
	nnoremap <buffer> ) <c-a>:try<bar>execute getline('.')<bar>catch<bar>undo<bar>endtry<cr>
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
    exec 'hi! '.a:grp.' ctermfg='.(a:fg ==# 'fg' ? 'NONE' : a:fg).' ctermbg='.(a:bg ==# 'bg' ? 'NONE' : a:bg).' cterm='.a:attr
    exec 'hi! ' . a:grp . ' guifg=' . rgb_fg . ' guibg=' . rgb_bg . ' gui=' . a:attr
endfunction

command! -buffer -bar -nargs=+ Hi call s:highlight(<f-args>)

" Link many groups in one go.

command! -buffer -nargs=+ Linkto call s:linkto(<f-args>)

set background=dark


" Default: |highlight-groups|
" ~~~~~~~

"  Group               FG   BG   STYLE
"  ------------------- ---- ---- ---------------------------------------
Hi ColorColumn         fg   235  NONE
Hi Conceal             240  bg   NONE
Hi Cursor              234  252  NONE
Hi lCursor             234  252  NONE
Hi CursorIM            234  252  NONE
Hi CursorColumn        fg   235  NONE
Hi CursorLine          NONE 234  NONE
Hi Directory           240  bg   NONE
Hi DiffAdd             65   bg   NONE
Hi DiffChange          250  234  bold
Hi DiffDelete          203  bg   NONE
Hi DiffText            173  bg   NONE
Hi EndOfBuffer         240  bg   NONE
Hi ErrorMsg            203  bg   NONE
Hi VertSplit           237  bg   NONE
Hi Folded              245  235  NONE
Hi FoldColumn          240  bg   NONE
Hi SignColumn          240  bg   NONE
Hi IncSearch           234  252  NONE
Hi LineNr              240  bg   NONE
Hi CursorLineNr        71   bg   NONE
Hi MatchParen          fg   bg   underline
Hi ModeMsg             250  234  NONE
Hi MoreMsg             250  234  NONE
Hi NonText             240  bg   NONE
Hi Normal              250  234  NONE
Hi Pmenu               252  237  NONE
Hi PmenuSel            234  252  NONE
Hi PmenuSbar           fg   238  NONE
Hi PmenuThumb          fg   243  NONE
Hi Question            250  234  NONE
Hi QuickFixLine        fg   bg   underline
Hi Search              190  bg   NONE
Hi SpecialKey          241  bg   NONE
Hi SpellBad            203  bg   underline
Hi SpellCap            180  bg   underline
Hi SpellLocal          180  bg   underline
Hi SpellRare           180  bg   underline
Hi StatusLine          71   237  NONE
Hi StatusLineNC        243  237  NONE
Hi StatusLineTerm      71   237  NONE
Hi StatusLineTermNC    243  237  NONE
Hi TabLine             243  237  NONE
Hi TabLineFill         243  237  NONE
Hi TabLineSel          71   237  NONE
Hi Terminal            250  234  NONE
Hi Title               252  NONE bold
Hi Visual              252  241  NONE
Hi VisualNOS           252  241  NONE
Hi WarningMsg          252  NONE bold
Hi WildMenu            253  235  bold

" Syntax: |group-name|
" ~~~~~~

"  Group               FG   BG   STYLE
"  ------------------- ---- ---- ---------------------------------------
Hi Comment             241  bg   NONE
Hi Constant            66   bg   NONE
Hi String              65   bg   NONE
Hi Character           66   bg   NONE
Hi Number              66   bg   NONE
Hi Boolean             66   bg   NONE
Hi Float               66   bg   NONE
Hi Identifier          250  234  NONE
Hi Function            250  234  NONE
Hi Statement           250  234  NONE
Hi Conditional         250  234  NONE
Hi Repeat              250  234  NONE
Hi Label               250  234  NONE
Hi Operator            252  NONE bold
Hi Keyword             252  NONE bold
Hi Exception           250  234  NONE
Hi PreProc             66   bg   NONE
Hi Include             66   bg   NONE
Hi Define              66   bg   NONE
Hi Macro               66   bg   NONE
Hi PreCondit           66   bg   NONE
Hi Type                66   bg   NONE
Hi StorageClass        66   bg   NONE
Hi Structure           66   bg   NONE
Hi Typedef             66   bg   NONE
Hi Special             66   bg   NONE
Hi SpecialChar         66   bg   NONE
Hi Tag                 66   bg   NONE
Hi Delimiter           66   bg   NONE
Hi SpecialComment      66   bg   NONE
Hi Debug               66   bg   NONE
Hi Underlined          NONE NONE underline
Hi Ignore              240  bg   NONE
Hi Error               203  bg   NONE
Hi Todo                fg   bg   underline

" User: |hl-User1..9|
" ~~~~

"  Group               FG   BG   STYLE
"  ------------------- ---- ---- ---------------------------------------
Hi User1               203  237  NONE
Hi User2               35   237  NONE
Hi User3               190  237  NONE
Hi User4               66   237  NONE
Hi User5               240  237  NONE
Hi User6               66   237  NONE
Hi User7               253  237  NONE

" Extra:
" ~~~~~

"  Group               FG   BG   STYLE
"  ------------------- ---- ---- ---------------------------------------
Hi vimCommentTitle     66   bg   NONE

Hi htmltagname         66   bg   NONE
Hi htmlspecialtagname  66   bg   NONE
Hi htmltag             250  234  NONE
Hi htmlendtag          250  234  NONE
Hi htmlarg             250  234  NONE
Hi htmlstring          65   bg   NONE
Hi htmlvalue           65   bg   NONE
Hi htmcomment          240  bg   NONE
Hi htmlcommentpart     240  bg   NONE

Hi cssProp             246  NONE NONE
Hi cssDefinition       246  NONE NONE
Hi cssBackgroundProp   246  NONE NONE
Hi cssMediaProp        246  NONE NONE
Hi cssPositioningProp  246  NONE NONE
Hi cssSelectorOp       246  NONE NONE

Hi DiffOnly            241  bg   NONE
Hi DiffIdentical       241  bg   NONE
Hi DiffDiffer          241  bg   NONE
Hi DiffBdiffer         241  bg   NONE
Hi DiffIsa             241  bg   NONE
Hi DiffNoeol           241  bg   NONE
Hi DiffCommon          241  bg   NONE
Hi DiffComment         240  bg   NONE
Hi DiffRemoved         203  bg   NONE
Hi DiffChanged         252  NONE bold
Hi DiffAdded           252  NONE bold
Hi DiffFile            252  NONE bold
Hi DiffConstant        241  bg   NONE
Hi DiffIndexLine       241  bg   NONE
Hi DiffSubname         241  bg   NONE
Hi DiffLine            241  bg   NONE

Hi HelpHypertextJump   252  NONE bold
Hi HelpCommand         252  NONE bold
Hi HelpOption          252  NONE bold
Hi HelpHyperTextEntry  241  bg   NONE
Hi HelpExample         241  bg   NONE

Hi MatchWordCur        NONE NONE underline
Hi MatchWord           NONE NONE underline

if !s:editingthisfile
	delcom Hi
endif

" vim: isk+=-,.:
