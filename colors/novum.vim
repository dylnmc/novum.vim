" novum.vim -- A dark colorscheme with a little monochrome syntax highlighting
"           -- and sprinkles of green and blue

highlight clear
let colors_name = 'novum'
set background=dark

command! -bang -bar -nargs=? -complete=customlist,novum#color_set_compl Novum call novum#color_set(<bang>0, <f-args>)
command! -bar -complete=highlight -nargs=+ H call s:hi(<f-args>)

" setup (:

let s:t_string = get(v:, 't_string', type(''))

let g:novum#defaults = {}
let g:novum#maxes = {}
let g:novum#colors = {}

function! s:setColor(name, def, lst) " set color default, max, color (:
	let g:novum#defaults[a:name] = a:def
	let g:novum#maxes[a:name] = len(a:lst)
	let g:novum#colors[a:name] = max([0, min([255, a:lst[ max([0, min([len(a:lst) - 1, str2nr(get(g:, 'novum_'.a:name, a:def))])]) ]])])
endfunction " :)

function! s:linkColor(name, link, inc, ...) " link previous color with increment (:
	let g:novum#defaults[a:name] = 0
	let g:novum#maxes[a:name] = 1
	let g:novum#colors[a:name] = max([0, get(a:000, 0, 0), min([255, get(a:000, 1, 255), g:novum#colors[a:link] + a:inc])])
endfunction " :)

function! s:hi(grp, fg, bg, attr) " (:
	let l:fg = a:fg =~? '^\%(\d\+\|none\)$' ? a:fg : g:novum#colors[a:fg]
	let l:bg = a:bg =~? '^\%(\d\+\|none\)$' ? a:bg : g:novum#colors[a:bg]
	exec printf('hi! %s ctermfg=%s ctermbg=%s cterm=%s', a:grp, l:fg, l:bg, a:attr)
	exec printf('hi! %s guifg=%s guibg=%s gui=%s', a:grp, l:fg =~# '^\d\+$' ? g:novum#xterm_colors[l:fg] : l:fg, l:bg =~# '^\d\+$' ? g:novum#xterm_colors[l:bg] : l:bg, a:attr)
endfunction " :)


" 256 xterm color palette (:

if !exists('g:novum#xterm_colors')

	let g:novum#xterm_colors = [ '#000000', '#c00000', '#008000', '#808000', '#000080', '#800080', '#008080', '#c0c0c0', '#808080', '#ff0000', '#00ff00', '#ffff00', '#0000ff', '#ff00ff', '#00ffff', '#ffffff', '#000000', '#00005f', '#000087', '#0000af', '#0000d7', '#0000ff', '#005f00', '#005f5f', '#005f87', '#005faf', '#005fd7', '#005fff', '#008700', '#00875f', '#008787', '#0087af', '#0087d7', '#0087ff', '#00af00', '#00af5f', '#00af87', '#00afaf', '#00afd7', '#00afff', '#00d700', '#00d75f', '#00d787', '#00d7af', '#00d7d7', '#00d7ff', '#00ff00', '#00ff5f', '#00ff87', '#00ffaf', '#00ffd7', '#00ffff', '#5f0000', '#5f005f', '#5f0087', '#5f00af', '#5f00d7', '#5f00ff', '#5f5f00', '#5f5f5f', '#5f5f87', '#5f5faf', '#5f5fd7', '#5f5fff', '#5f8700', '#5f875f', '#5f8787', '#5f87af', '#5f87d7', '#5f87ff', '#5faf00', '#5faf5f', '#5faf87', '#5fafaf', '#5fafd7', '#5fafff', '#5fd700', '#5fd75f', '#5fd787', '#5fd7af', '#5fd7d7', '#5fd7ff', '#5fff00', '#5fff5f', '#5fff87', '#5fffaf', '#5fffd7', '#5fffff', '#870000', '#87005f', '#870087', '#8700af', '#8700d7', '#8700ff', '#875f00', '#875f5f', '#875f87', '#875faf', '#875fd7', '#875fff', '#878700', '#87875f', '#878787', '#8787af', '#8787d7', '#8787ff', '#87af00', '#87af5f', '#87af87', '#87afaf', '#87afd7', '#87afff', '#87d700', '#87d75f', '#87d787', '#87d7af', '#87d7d7', '#87d7ff', '#87ff00', '#87ff5f', '#87ff87', '#87ffaf', '#87ffd7', '#87ffff', '#af0000', '#af005f', '#af0087', '#af00af', '#af00d7', '#af00ff', '#af5f00', '#af5f5f', '#af5f87', '#af5faf', '#af5fd7', '#af5fff', '#af8700', '#af875f', '#af8787', '#af87af', '#af87d7', '#af87ff', '#afaf00', '#afaf5f', '#afaf87', '#afafaf', '#afafd7', '#afafff', '#afd700', '#afd75f', '#afd787', '#afd7af', '#afd7d7', '#afd7ff', '#afff00', '#afff5f', '#afff87', '#afffaf', '#afffd7', '#afffff', '#d70000', '#d7005f', '#d70087', '#d700af', '#d700d7', '#d700ff', '#d75f00', '#d75f5f', '#d75f87', '#d75faf', '#d75fd7', '#d75fff', '#d78700', '#d7875f', '#d78787', '#d787af', '#d787d7', '#d787ff', '#d7af00', '#d7af5f', '#d7af87', '#d7afaf', '#d7afd7', '#d7afff', '#d7d700', '#d7d75f', '#d7d787', '#d7d7af', '#d7d7d7', '#d7d7ff', '#d7ff00', '#d7ff5f', '#d7ff87', '#d7ffaf', '#d7ffd7', '#d7ffff', '#ff0000', '#ff005f', '#ff0087', '#ff00af', '#ff00d7', '#ff00ff', '#ff5f00', '#ff5f5f', '#ff5f87', '#ff5faf', '#ff5fd7', '#ff5fff', '#ff8700', '#ff875f', '#ff8787', '#ff87af', '#ff87d7', '#ff87ff', '#ffaf00', '#ffaf5f', '#ffaf87', '#ffafaf', '#ffafd7', '#ffafff', '#ffd700', '#ffd75f', '#ffd787', '#ffd7af', '#ffd7d7', '#ffd7ff', '#ffff00', '#ffff5f', '#ffff87', '#ffffaf', '#ffffd7', '#ffffff', '#080808', '#121212', '#1c1c1c', '#262626', '#303030', '#3a3a3a', '#444444', '#4e4e4e', '#585858', '#626262', '#6c6c6c', '#767676', '#808080', '#8a8a8a', '#949494', '#9e9e9e', '#a8a8a8', '#b2b2b2', '#bcbcbc', '#c6c6c6', '#d0d0d0', '#dadada', '#e4e4e4', '#eeeeee' ]

endif

" :)

" :)

" colors (:

" normal foreground
call s:setColor('fg', 3, range(248, 254, 2))

" normal background
call s:setColor('bg', 2, range(232, 242))
" call s:setColor('bg', 0, [234])

" light background
call s:linkColor('lightbg', 'bg', 2)

" dark foreground
call s:linkColor('darkfg', 'lightbg', 10)

" brighter background
call s:linkColor('brightbg', 'bg', 2)

" darker foreground
call s:linkColor('darkerfg', 'brightbg', 10)

" selection
call s:linkColor('select', 'bg', 8)

" selection fg
call s:setColor('selectfg', 0, [255])

" darker foreground
call s:linkColor('darkfg', 'fg', -4)

" UI background
call s:linkColor('uibg', 'bg', 5)

" UI foreground
call s:linkColor('uifg', 'uibg', 10)

" UI background NC
call s:linkColor('uibgnc', 'uibg', -2)

" UI foreground NC
call s:linkColor('uifgnc', 'uibgnc', 10)

" comment
call s:setColor('comment', 4, range(g:novum#colors.bg + 3, g:novum#colors.fg - 4))

" dark blue
call s:setColor('darkblue', 0, [25, 31, 38])

" blue
call s:setColor('blue', 1, [31, 38, 45])

" light blue
call s:setColor('lightblue', 0, [45])

" dark green
call s:setColor('darkgreen', 0, [29])

" green
call s:setColor('green', 1, [29, 36, 42])

" light green
call s:setColor('lightgreen', 0, [42])

" red
call s:setColor('red', 0, [203])

" dark orange
call s:setColor('darkorange', 1, [130, 166])

" orange
call s:setColor('orange', 0, [209])

" light orange
call s:setColor('lightorange', 0, [216])

" dark yellow
call s:setColor('darkyellow', 1, [94, 136, 179])

" yellow
call s:setColor('yellow', 1, [136, 179, 222])

" light yellow
call s:setColor('lightyellow', 1, [179, 222, 228])

" purple
call s:setColor('purple', 0, [176])

" :)

" Default: |highlight-groups| (:
" ~~~~~~~

" Group                 FG           BG           STYLE
" --------------------- ------------ ------------ -------------------------------
H ColorColumn           NONE         lightbg      NONE
H Conceal               comment      NONE         NONE
H Cursor                bg           fg           NONE
H lCursor               bg           fg           NONE
H CursorIM              bg           fg           NONE
H CursorColumn          NONE         lightbg      NONE
H CursorLine            NONE         lightbg      NONE
H Directory             blue         NONE         NONE
H DiffAdd               green        lightbg      bold
H DiffChange            orange       NONE         bold
H DiffDelete            red          NONE         NONE
H DiffText              darkfg       NONE         NONE
H EndOfBuffer           comment      NONE         NONE
H ErrorMsg              red          NONE         NONE
H VertSplit             comment      uibg         NONE
H Folded                darkerfg     brightbg     NONE
H FoldColumn            comment      NONE         NONE
H SignColumn            comment      NONE         NONE
H IncSearch             lightyellow  bg           reverse
H LineNr                darkerfg     NONE         NONE
H CursorLineNr          green        NONE         NONE
H MatchParen            NONE         NONE         underline
H ModeMsg               orange       NONE         NONE
H MoreMsg               orange       NONE         NONE
H NonText               comment      NONE         NONE
H Normal                fg           bg           NONE
H Pmenu                 fg           uibg         NONE
H PmenuSel              bg           fg           NONE
H PmenuSbar             fg           lightbg      NONE
H PmenuThumb            fg           uifgnc       NONE
H Question              orange       NONE         NONE
H QuickFixLine          NONE         NONE         underline
H Search                lightyellow  NONE         NONE
H SpecialKey            darkfg       NONE         NONE
H SpellBad              red          NONE         NONE
H SpellCap              yellow       NONE         NONE
H SpellLocal            yellow       NONE         NONE
H SpellRare             yellow       NONE         NONE
H StatusLine            uifg         uibg         NONE
H StatusLineNC          uifgnc       uibgnc       NONE
H StatusLineTerm        uifg         uibg         NONE
H StatusLineTermNC      uifgnc       uibgnc       NONE
H TabLine               uifgnc       uibg         NONE
H TabLineFill           uifgnc       uibg         NONE
H TabLineSel            lightgreen   uibg         NONE
H Terminal              NONE         bg           NONE
H Title                 NONE         NONE         bold
H Visual                selectfg     select       NONE
H VisualNOS             selectfg     select       NONE
H WarningMsg            yellow       NONE         bold
H WildMenu              green        uibg         bold

" :)
" Syntax: |group-name| (:
" ~~~~~~

" Group                 FG           BG           STYLE
" --------------------- ------------ ------------ -------------------------------
H Comment               comment      NONE         NONE
H Constant              blue         NONE         NONE
H String                green        NONE         NONE
H Character             green        NONE         NONE
H Number                purple       NONE         NONE
H Boolean               purple       NONE         NONE
H Float                 purple       NONE         NONE
H Identifier            NONE         NONE         NONE
H Function              NONE         NONE         NONE
H Statement             blue         NONE         NONE
H Conditional           blue         NONE         NONE
H Repeat                blue         NONE         NONE
H Label                 blue         NONE         NONE
H Operator              darkfg       NONE         NONE
H Keyword               darkfg       NONE         NONE
H Exception             blue         NONE         NONE
H PreProc               blue         NONE         NONE
H Include               blue         NONE         NONE
H Define                blue         NONE         NONE
H Macro                 blue         NONE         NONE
H PreCondit             blue         NONE         NONE
H Type                  blue         NONE         NONE
H StorageClass          blue         NONE         NONE
H Structure             blue         NONE         NONE
H Typedef               blue         NONE         NONE
H Special               blue         NONE         NONE
H SpecialChar           blue         NONE         NONE
H Tag                   blue         NONE         NONE
H Delimiter             darkfg       NONE         NONE
H SpecialComment        blue         NONE         NONE
H Debug                 orange       NONE         NONE
H Underlined            NONE         NONE         underline
H Ignore                comment      NONE         NONE
H Error                 red          NONE         NONE
H Todo                  fg           NONE         underline

" :)
" User: |hl-User1..9| (:
" ~~~~

" Group                 FG           BG           STYLE
" --------------------- ------------ ------------ -------------------------------
H User1                 red          uibg         NONE
H User2                 lightgreen   uibg         NONE
H User3                 yellow       uibg         NONE
H User4                 blue         uibg         NONE
H User5                 purple       uibg         NONE
H User6                 blue         uibg         NONE
H User7                 fg           uibg         NONE
H User8                 uifgnc       uibg         NONE
H User9                 247          uibg         NONE

" :)
" Extra: (:
" ~~~~~

" Group                 FG           BG           STYLE
" --------------------- ------------ ------------ -------------------------------
H htmltagname           blue         NONE         NONE
H htmlspecialtagname    blue         NONE         NONE
H htmltag               NONE         NONE         NONE
H htmlendtag            NONE         NONE         NONE
H htmlarg               NONE         NONE         NONE
H htmlstring            green        NONE         NONE
H htmlvalue             green        NONE         NONE
H htmcomment            comment      NONE         NONE
H htmlcommentpart       comment      NONE         NONE
" --------------------- ------------ ------------ -------------------------------
H cssProp               darkfg       NONE         NONE
H cssDefinition         darkfg       NONE         NONE
H cssBackgroundProp     darkfg       NONE         NONE
H cssMediaProp          darkfg       NONE         NONE
H cssPositioningProp    darkfg       NONE         NONE
H cssSelectorOp         darkfg       NONE         NONE
" --------------------- ------------ ------------ -------------------------------
H DiffOnly              comment      NONE         NONE
H DiffIdentical         comment      NONE         NONE
H DiffDiffer            comment      NONE         NONE
H DiffBdiffer           comment      NONE         NONE
H DiffIsa               comment      NONE         NONE
H DiffNoeol             comment      NONE         NONE
H DiffCommon            comment      NONE         NONE
H DiffComment           comment      NONE         NONE
H DiffRemoved           red          NONE         NONE
H DiffChanged           NONE         NONE         bold
H DiffAdded             NONE         NONE         bold
H DiffFile              NONE         NONE         bold
H DiffConstant          comment      NONE         NONE
H DiffIndexLine         comment      NONE         NONE
H DiffSubname           comment      NONE         NONE
H DiffLine              darkfg       NONE         NONE
" --------------------- ------------ ------------ -------------------------------
H helpHypertextJump     NONE         NONE         bold
H helpCommand           NONE         NONE         bold
H helpOption            NONE         NONE         bold
H helpHyperTextEntry    darkfg       NONE         NONE
H helpHyperTextJump     darkfg       NONE         NONE
H helpExample           darkfg       NONE         NONE
H helpVim               uifg         NONE         bold
" --------------------- ------------ ------------ -------------------------------
H vimHiGuiFgBg          darkfg       NONE         NONE
H vimHiCtermFgBg        darkfg       NONE         NONE
H vimHiCTerm            darkfg       NONE         NONE
H vimHiGui              darkfg       NONE         NONE
H vimFuncVar            darkfg       NONE         NONE
H vimCommentTitle       orange       NONE         bold
H vimOption             fg           NONE         NONE
H vimEchoHLNone         NONE         NONE         NONE
" --------------------- ------------ ------------ -------------------------------
H MatchWordCur          NONE         NONE         underline
H MatchWord             NONE         NONE         underline
" --------------------- ------------ ------------ -------------------------------
H manSectionHeading     blue         NONE         bold
" --------------------- ------------ ------------ -------------------------------
H markdownCodeDelimiter bg           darkgreen    NONE
H markdownCode          green        NONE         NONE

" :)

" vim: cole=2 cocu=cv fdm=marker fmr=\(\:,\:\) fdl=0:
