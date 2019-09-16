
function! s:print(group)
	let l:color = g:novum#colors[a:group]
	exec printf('hi novum_%s_hi guifg=%s ctermfg=%d', a:group, g:novum#xterm_colors[l:color], l:color)
	if a:group ==# 'bg'
		exec printf('hi novum_%s_hi guibg=white ctermbg=255', a:group)
	endif
	exec printf('echohl novum_%s_hi', a:group)
	let l:def = g:novum#defaults[a:group]
	let l:i = get(g:, 'novum_'.a:group, l:def)
	echom printf('%s[%d] -> %s %s -> default%s', a:group, l:i, l:color, g:novum#xterm_colors[l:color], l:i ==# l:def ? '' : printf(': %s[%d]', a:group, l:def))
	exec printf('hi clear novum_%s_hi', a:group)
	echohl NONE
endfunction

function! novum#color_set(bang, ...) " (:
	if !a:0
		echohl ErrorMsg
		echom 'usage .. :Novum[!] group [[+-]num] .. eg, :Novum blue +1'
		echohl NONE
		return
	endif
	let l:bang = a:bang
	let l:args = split(a:1)
	let l:group = l:args[0]
	if l:group[-1:] ==# '!'
		let l:bang = 1
		let l:group = l:group[:-2]
	endif
	if len(l:args) > 1
		let l:val = l:args[1]
		if l:val[0] =~# '[+-]'
			let l:num = get(g:, 'novum_'.l:group, g:novum#defaults[l:group]) + eval(l:val[0] . str2nr(l:val[1:]))
		else
			let l:num = str2nr(l:val)
		endif
		let g:['novum_'.l:group] = min([g:novum#maxes[l:group] - 1, max([0, l:num])])
	else
		if l:bang
			if exists('g:novum_'.l:group)
				unlet g:['novum_'.l:group]
			endif
		else
			call s:print(l:group)
			return
		endif
	endif
	mkview
	colorscheme novum
	loadview
	redraw!
	call s:print(l:group)
endfunction " :)

function! novum#color_set_compl(arglead, cmdline, curpos) abort " (:
	let l:args = split(a:cmdline, '\s\+')
	let l:argn = len(l:args)
	if l:argn ==# 1
		return keys(g:novum#maxes)
	elseif l:argn ==# 2
		if a:cmdline =~# '\s\+$'
			return map(range(0, g:novum#maxes[l:args[1]]), { _,v -> string(v) })
		endif
		return filter(keys(g:novum#maxes), { _,v -> stridx(v, a:arglead) ==# 0 })
	elseif l:argn ==# 3
		if a:cmdline !~# '\s\+$'
			return map(range(0, g:novum#maxes[l:args[1]]), { _,v -> string(v) })
		endif
	endif
	return []
endfunction " :)

function! novum#setup_colors(init) " (:
	if expand('%:p') !~# '\/colors\/novum\.vim$' || get(b:, 'novum_no_setup')
		return
	endif
	if !get(b:, 'novum_colors_setup')
		autocmd BufWinEnter <buffer> call novum#setup_colors(0)
		autocmd BufWinLeave <buffer> call clearmatches()
		autocmd BufWritePost <buffer> if !get(b:, 'novum_no_setup')|try|colo novum|call novum#setup_colors(0)|catch|redraw!|echoerr 'Error loading novum.vim'|endtry|endif
		let b:novum_colors_setup = 1
	endif
	call clearmatches()
	let l:linenr = 0
	for l:line in getline(1, '$')
		let l:linenr += 1
		if l:line !~# '^H\s\+\w'
			continue
		endif
		let l:group = split(l:line, '\s\+')[1]
		call matchaddpos(l:group, [[l:linenr]])
	endfor
	if &termguicolors
		let [l:linenr,l:colnr] = searchpos('let\s\+g:novum#xterm_colors\s*=\s*\[\s*\zs\S', 'n')
		let l:colnr += 1
		let l:line = split(getline(l:linenr)[l:colnr-1 : -4], "', '")
		for l:i in range(256)
			let l:col = 'xterm_col_'.l:i
			execute printf('hi %s guifg=%s', l:col, l:line[l:i])
			call matchaddpos(l:col, [[l:linenr, l:colnr + 11 * l:i, 7]])
			let l:nums = printf('%3d', l:i)
			call matchaddpos('Conceal', [[l:linenr, l:colnr + 11 * l:i - 4, 1]], 11, -1, { 'conceal': l:nums[0] })
			call matchaddpos('Conceal', [[l:linenr, l:colnr + 11 * l:i - 3, 1]], 11, -1, { 'conceal': l:nums[1] })
			call matchaddpos('Conceal', [[l:linenr, l:colnr + 11 * l:i - 2, 1]], 11, -1, { 'conceal': l:nums[2] })
			call matchaddpos('Conceal', [[l:linenr, l:colnr + 11 * l:i - 1, 1]], 11, -1, { 'conceal': ':' })
		endfor
	endif
	if !a:init
		if exists('#User#NovumColorUpdate')
			doautocmd User NovumColorUpdate
		endif
	endif
endfunction " :)

" vim: fdm=marker fmr=\(\:,\:\) fdl=0:
