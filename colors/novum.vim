" novum.vim -- A dark colorscheme with a little monochrome syntax highlighting
"           -- and sprinkles of green and blue

highlight clear
let colors_name = 'novum'
set background=dark

" colors (:

let s:colors = {}

" normal foreground
let s:colors.fg = 250

" normal background
let s:colors.bg = 234

" light background
let s:colors.lightbg = 235

" selection
let s:colors.select = 241

" dark background
let s:colors.darkfg = 102

" UI foreground
let s:colors.uifg = 253

" UI background
let s:colors.uibg = 237

" UI foreground NC
let s:colors.uifgnc = 243

" comment
let s:colors.comment = 240

" blue
let s:colors.blue = 66

" green
let s:colors.green = 65
let s:colors.brightgreen = 77

" red
let s:colors.red = 203

" orange
let s:colors.orange = 130
let s:colors.brightorange = 214

" yellow
let s:colors.yellow = 136
let s:colors.brightyellow = 190

" purple
let s:colors.purple = 35

" expose g:novum_colors
let g:novum_colors = s:colors

" :)
" 256 xterm color palette (:

let s:rgb = [ '#000000', '#c00000', '#008000', '#808000', '#000080', '#800080', '#008080', '#c0c0c0', '#808080', '#ff0000', '#00ff00', '#ffff00', '#0000ff', '#ff00ff', '#00ffff', '#ffffff', '#000000', '#00005f', '#000087', '#0000af', '#0000d7', '#0000ff', '#005f00', '#005f5f', '#005f87', '#005faf', '#005fd7', '#005fff', '#008700', '#00875f', '#008787', '#0087af', '#0087d7', '#0087ff', '#00af00', '#00af5f', '#00af87', '#00afaf', '#00afd7', '#00afff', '#00d700', '#00d75f', '#00d787', '#00d7af', '#00d7d7', '#00d7ff', '#00ff00', '#00ff5f', '#00ff87', '#00ffaf', '#00ffd7', '#00ffff', '#5f0000', '#5f005f', '#5f0087', '#5f00af', '#5f00d7', '#5f00ff', '#5f5f00', '#5f5f5f', '#5f5f87', '#5f5faf', '#5f5fd7', '#5f5fff', '#5f8700', '#5f875f', '#5f8787', '#5f87af', '#5f87d7', '#5f87ff', '#5faf00', '#5faf5f', '#5faf87', '#5fafaf', '#5fafd7', '#5fafff', '#5fd700', '#5fd75f', '#5fd787', '#5fd7af', '#5fd7d7', '#5fd7ff', '#5fff00', '#5fff5f', '#5fff87', '#5fffaf', '#5fffd7', '#5fffff', '#870000', '#87005f', '#870087', '#8700af', '#8700d7', '#8700ff', '#875f00', '#875f5f', '#875f87', '#875faf', '#875fd7', '#875fff', '#878700', '#87875f', '#878787', '#8787af', '#8787d7', '#8787ff', '#87af00', '#87af5f', '#87af87', '#87afaf', '#87afd7', '#87afff', '#87d700', '#87d75f', '#87d787', '#87d7af', '#87d7d7', '#87d7ff', '#87ff00', '#87ff5f', '#87ff87', '#87ffaf', '#87ffd7', '#87ffff', '#af0000', '#af005f', '#af0087', '#af00af', '#af00d7', '#af00ff', '#af5f00', '#af5f5f', '#af5f87', '#af5faf', '#af5fd7', '#af5fff', '#af8700', '#af875f', '#af8787', '#af87af', '#af87d7', '#af87ff', '#afaf00', '#afaf5f', '#afaf87', '#afafaf', '#afafd7', '#afafff', '#afd700', '#afd75f', '#afd787', '#afd7af', '#afd7d7', '#afd7ff', '#afff00', '#afff5f', '#afff87', '#afffaf', '#afffd7', '#afffff', '#d70000', '#d7005f', '#d70087', '#d700af', '#d700d7', '#d700ff', '#d75f00', '#d75f5f', '#d75f87', '#d75faf', '#d75fd7', '#d75fff', '#d78700', '#d7875f', '#d78787', '#d787af', '#d787d7', '#d787ff', '#d7af00', '#d7af5f', '#d7af87', '#d7afaf', '#d7afd7', '#d7afff', '#d7d700', '#d7d75f', '#d7d787', '#d7d7af', '#d7d7d7', '#d7d7ff', '#d7ff00', '#d7ff5f', '#d7ff87', '#d7ffaf', '#d7ffd7', '#d7ffff', '#ff0000', '#ff005f', '#ff0087', '#ff00af', '#ff00d7', '#ff00ff', '#ff5f00', '#ff5f5f', '#ff5f87', '#ff5faf', '#ff5fd7', '#ff5fff', '#ff8700', '#ff875f', '#ff8787', '#ff87af', '#ff87d7', '#ff87ff', '#ffaf00', '#ffaf5f', '#ffaf87', '#ffafaf', '#ffafd7', '#ffafff', '#ffd700', '#ffd75f', '#ffd787', '#ffd7af', '#ffd7d7', '#ffd7ff', '#ffff00', '#ffff5f', '#ffff87', '#ffffaf', '#ffffd7', '#ffffff', '#080808', '#121212', '#1c1c1c', '#262626', '#303030', '#3a3a3a', '#444444', '#4e4e4e', '#585858', '#626262', '#6c6c6c', '#767676', '#808080', '#8a8a8a', '#949494', '#9e9e9e', '#a8a8a8', '#b2b2b2', '#bcbcbc', '#c6c6c6', '#d0d0d0', '#dadada', '#e4e4e4', '#eeeeee' ]

" :)
function! s:highlight(grp, fg, bg, attr) " (:
	let l:fg = a:fg =~? '^\%(\d\+\|none\)$' ? a:fg : s:colors[a:fg]
	let l:bg = a:bg =~? '^\%(\d\+\|none\)$' ? a:bg : s:colors[a:bg]
	exec printf('hi! %s ctermfg=%s ctermbg=%s cterm=%s', a:grp, l:fg, l:bg, a:attr)
	exec printf('hi! %s guifg=%s guibg=%s gui=%s', a:grp, l:fg =~# '^\d\+$' ? s:rgb[l:fg] : l:fg, l:bg =~# '^\d\+$' ? s:rgb[l:bg] : l:bg, a:attr)
endfunction " :)

command! -buffer -bar -nargs=+ Hi call s:highlight(<f-args>)

" Default: |highlight-groups| (:
" ~~~~~~~

"  Group               FG           BG           STYLE
"  ------------------- ------------ ------------ -------------------------------
Hi ColorColumn         NONE         lightbg      NONE
Hi Conceal             comment      NONE         NONE
Hi Cursor              bg           fg           NONE
Hi lCursor             bg           fg           NONE
Hi CursorIM            bg           fg           NONE
Hi CursorColumn        NONE         lightbg      NONE
Hi CursorLine          NONE         NONE         NONE
Hi Directory           blue         NONE         NONE
Hi DiffAdd             green        lightbg      bold
Hi DiffChange          orange       NONE         bold
Hi DiffDelete          red          NONE         NONE
Hi DiffText            darkfg       NONE         NONE
Hi EndOfBuffer         comment      NONE         NONE
Hi ErrorMsg            red          NONE         NONE
Hi VertSplit           comment      comment      NONE
Hi Folded              243          lightbg      NONE
Hi FoldColumn          comment      NONE         NONE
Hi SignColumn          comment      NONE         NONE
Hi IncSearch           bg           brightyellow NONE
Hi LineNr              comment      NONE         NONE
Hi CursorLineNr        brightgreen  NONE         NONE
Hi MatchParen          NONE         NONE         underline
Hi ModeMsg             NONE         NONE         NONE
Hi MoreMsg             NONE         NONE         NONE
Hi NonText             comment      NONE         NONE
Hi Normal              fg           bg           NONE
Hi Pmenu               NONE         uibg         NONE
Hi PmenuSel            bg           fg           NONE
Hi PmenuSbar           NONE         lightbg      NONE
Hi PmenuThumb          NONE         uifgnc       NONE
Hi Question            green        NONE         NONE
Hi QuickFixLine        NONE         NONE         underline
Hi Search              brightyellow NONE         NONE
Hi SpecialKey          darkfg       NONE         NONE
Hi SpellBad            red          NONE         NONE
Hi SpellCap            yellow       NONE         NONE
Hi SpellLocal          yellow       NONE         NONE
Hi SpellRare           yellow       NONE         NONE
Hi StatusLine          uifg         uibg         NONE
Hi StatusLineNC        uifgnc       uibg         NONE
Hi StatusLineTerm      uifg         uibg         NONE
Hi StatusLineTermNC    uifgnc       uibg         NONE
Hi TabLine             uifgnc       uibg         NONE
Hi TabLineFill         uifgnc       uibg         NONE
Hi TabLineSel          brightgreen  uibg         NONE
Hi Terminal            NONE         bg           NONE
Hi Title               NONE         NONE         bold
Hi Visual              NONE         select       NONE
Hi VisualNOS           NONE         select       NONE
Hi WarningMsg          NONE         NONE         bold
Hi WildMenu            NONE         lightbg      bold

" :)
" Syntax: |group-name| (:
" ~~~~~~

"  Group               FG           BG           STYLE
"  ------------------- ------------ ------------ -------------------------------
Hi Comment             comment  NONE   NONE
Hi Constant            blue   NONE   NONE
Hi String              green NONE   NONE
Hi Character           green  NONE   NONE
Hi Number              blue   NONE   NONE
Hi Boolean             blue   NONE   NONE
Hi Float               blue   NONE   NONE
Hi Identifier          NONE   NONE   NONE
Hi Function            blue   NONE   NONE
Hi Statement           darkfg  NONE   NONE
Hi Conditional         darkfg  NONE   NONE
Hi Repeat              darkfg  NONE   NONE
Hi Label               NONE  NONE  NONE
Hi Operator            NONE  NONE bold
Hi Keyword             NONE  NONE bold
Hi Exception           NONE  NONE  NONE
Hi PreProc             blue   NONE   NONE
Hi Include             blue   NONE   NONE
Hi Define              blue   NONE   NONE
Hi Macro               blue   NONE   NONE
Hi PreCondit           blue   NONE   NONE
Hi Type                blue   NONE   NONE
Hi StorageClass        blue   NONE   NONE
Hi Structure           blue   NONE   NONE
Hi Typedef             blue   NONE   NONE
Hi Special             blue   NONE   NONE
Hi SpecialChar         blue   NONE   NONE
Hi Tag                 blue   NONE   NONE
Hi Delimiter           NONE   NONE   NONE
Hi SpecialComment      blue   NONE   NONE
Hi Debug               blue   NONE   NONE
Hi Underlined          NONE NONE underline
Hi Ignore              comment  NONE   NONE
Hi Error               red  NONE   NONE
Hi Todo                fg   NONE   underline

" :)
" User: |hl-User1..9| (:
" ~~~~

"  Group               FG           BG           STYLE
"  ------------------- ------------ ------------ -------------------------------
Hi User1               red  uibg  NONE
Hi User2               brightgreen   uibg  NONE
Hi User3               yellow  uibg  NONE
Hi User4               blue   uibg  NONE
Hi User5               comment  uibg  NONE
Hi User6               blue   uibg  NONE
Hi User7               fg   uibg  NONE
Hi User8               uifgnc  uibg  NONE
Hi User9               247  uibg NONE

" :)
" Extra: (:
" ~~~~~

"  Group               FG           BG           STYLE
"  ------------------- ------------ ------------ -------------------------------
Hi htmltagname         blue   NONE NONE
Hi htmlspecialtagname  blue   NONE NONE
Hi htmltag             NONE  NONE NONE
Hi htmlendtag          NONE  NONE NONE
Hi htmlarg             NONE  NONE NONE
Hi htmlstring          green   NONE NONE
Hi htmlvalue           green   NONE NONE
Hi htmcomment          comment NONE NONE
Hi htmlcommentpart     comment NONE NONE

Hi cssProp             darkfg NONE NONE
Hi cssDefinition       darkfg NONE NONE
Hi cssBackgroundProp   darkfg NONE NONE
Hi cssMediaProp        darkfg NONE NONE
Hi cssPositioningProp  darkfg NONE NONE
Hi cssSelectorOp       darkfg NONE NONE

Hi DiffOnly            comment NONE NONE
Hi DiffIdentical       comment NONE NONE
Hi DiffDiffer          comment NONE NONE
Hi DiffBdiffer         comment NONE NONE
Hi DiffIsa             comment NONE NONE
Hi DiffNoeol           comment NONE NONE
Hi DiffCommon          comment NONE NONE
Hi DiffComment         comment NONE NONE
Hi DiffRemoved         red  NONE NONE
Hi DiffChanged         NONE  NONE bold
Hi DiffAdded           NONE  NONE bold
Hi DiffFile            NONE  NONE bold
Hi DiffConstant        comment NONE NONE
Hi DiffIndexLine       comment NONE NONE
Hi DiffSubname         comment NONE NONE
Hi DiffLine            comment NONE NONE

Hi HelpHypertextJump   NONE  NONE bold
Hi HelpCommand         NONE  NONE bold
Hi HelpOption          NONE  NONE bold
Hi HelpHyperTextEntry  darkfg  NONE NONE
Hi HelpExample         darkfg  NONE NONE

Hi vimHiGroup green NONE NONE
Hi vimHiGuiFgBg blue NONE NONE
Hi vimHiCtermFgBg blue NONE NONE
Hi vimFunction blue NONE NONE
Hi vimFuncVar darkfg NONE NONE
Hi vimCommentTitle fg NONE bold

Hi MatchWordCur        NONE NONE underline
Hi MatchWord           NONE NONE underline

" :)

" vim: isk+=-,. fdm=marker fmr=\(\:,\:\) fdl=0:
