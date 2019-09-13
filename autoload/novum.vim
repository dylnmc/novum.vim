
let s:defaults = { 'fg': 1, 'bg': 1, 'blue': 1, 'green': 1, 'brightyellow': 0, 'comment': 0 }

let s:maxes = { 'fg': 4, 'bg': 4, 'blue': 3, 'green': 3, 'brightyellow': 2, 'comment': 4 }

function! novum#color_set(bang, group, val) " (:
	if a:val[0] =~# '[+-]'
		let l:num = get(g:, 'novum_'.a:group, s:defaults[a:group]) + eval(a:val[0] . str2nr(a:val[1:]))
	else
		let l:num = str2nr(a:val)
	endif
	let g:['novum_'.a:group] = min([s:maxes[a:group] - 1, max([0, l:num])])
	colorscheme novum
endfunction " :)

function! novum#color_set_compl(arglead, cmdline, curpos) abort " (:
	let l:args = split(a:cmdline, '\s\+')
	let l:argn = len(l:args)
	if l:argn ==# 1
		return keys(s:maxes)
	elseif l:argn ==# 2
		if a:cmdline =~# '\s\+$'
			return map(range(0, s:maxes[l:args[1]]), { _,v -> string(v) })
		endif
		return filter(keys(s:maxes), { _,v -> stridx(v, a:arglead) ==# 0 })
	elseif l:argn ==# 3
		if a:cmdline !~# '\s\+$'
			return map(range(0, s:maxes[l:args[1]]), { _,v -> string(v) })
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
		autocmd BufWritePost <buffer> if !get(b:, 'novum_no_setup')|try|colo novum|call novum#setup_colors(0)|catch|endtry|endif
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
		let l:linenr = search('let s:rgb = \[', 'n')
		let l:line = split(getline(l:linenr)[15:-4], "', '")
		for l:i in range(256)
			let l:col = 'xterm_col_'.l:i
			execute printf('hi %s guifg=%s', l:col, l:line[l:i])
			call matchaddpos(l:col, [[l:linenr, 16 + 11 * l:i, 7]])
			let l:nums = printf('%3d', l:i)
			call matchaddpos('Conceal', [[l:linenr, 12 + 11 * l:i, 1]], 11, -1, { 'conceal': l:nums[0] })
			call matchaddpos('Conceal', [[l:linenr, 12 + 11 * l:i + 1, 1]], 11, -1, { 'conceal': l:nums[1] })
			call matchaddpos('Conceal', [[l:linenr, 12 + 11 * l:i + 2, 1]], 11, -1, { 'conceal': l:nums[2] })
			call matchaddpos('Conceal', [[l:linenr, 12 + 11 * l:i + 3, 1]], 11, -1, { 'conceal': ':' })
		endfor
	endif
	if !a:init
		if exists('#User#NovumColorUpdate')
			doautocmd User NovumColorUpdate
		endif
	endif
endfunction " :)

" vim: fdm=marker fmr=\(\:,\:\) fdl=0:
