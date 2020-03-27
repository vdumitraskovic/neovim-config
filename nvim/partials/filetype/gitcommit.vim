augroup gitcommit
  autocmd!
  autocmd FileType gitcommit call s:add_commit_prefix_from_branch()
augroup END

function! s:add_commit_prefix_from_branch() abort
  if expand('%') ==? '.git/COMMIT_EDITMSG' && empty(getline(1))
    let head = fugitive#head()
    if stridx(head, '/') > -1
      call setline(1, '['.split(head, '/')[1].'] ')
      startinsert!
    endif
  endif
endfunction

