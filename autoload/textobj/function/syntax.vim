"=============================================================================
" FILE: autoload/textobj/function/syntax.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:Synblock = vital#synblock#import('Vim.Synblock')

function! textobj#function#syntax#select(object_type) abort
  if a:object_type ==# 'a'
    return textobj#function#syntax#func_select_a_line()
  elseif a:object_type ==# 'i'
    return textobj#function#syntax#func_select_i_line()
  endif
  return
endfunction

function! textobj#function#syntax#func_select_i_line(...) abort
  let synname_body = get(a:, 1, s:detect_funcbody_synname())
  let block = s:Synblock.synblock(line('.'), col('.'), synname_body)
  if empty(block)
    return 0
  endif
  let start = [0] + block.start + [0]
  let start[1] += 1
  let end = [0] + block.end + [0]
  if getline(block.end[0])[:block.end[1]-1] =~# '^\s\+$'
    let end[1] -= 1
  endif
  return ['V', start, end]
endfunction

function! textobj#function#syntax#func_select_a_line(...) abort
  let synname_body = get(a:, 1, s:detect_funcbody_synname())
  let block = s:Synblock.synblock(line('.'), col('.'), synname_body)
  if empty(block)
    return 0
  endif
  let start = [0] + block.start + [0]
  let end = [0] + block.end + [0]
  if getline(block.end[0])[:block.end[1]-1] !~# '^\s\+$'
    let end[1] += 1
  endif
  return ['V', start, end]
endfunction

function! s:detect_funcbody_synname() abort
  let synnames = map(synstack(line('.'), col('.')), {_, id -> synIDattr(id, 'name')})
  for re in ['funcblock', 'funcbody', 'functionblock', 'functionbody', 'methodblock', 'block', 'brace']
    for name in synnames
      if name =~? re
        return name
      endif
    endfor
  endfor
  return ''
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
