set pumheight=15                                                                "Maximum number of entries in autocomplete popup

augroup vimrc_autocomplete
  autocmd!
  autocmd VimEnter * lua require'lsp_setup'
  autocmd FileType javascript,javascriptreact,vim,php,gopls setlocal omnifunc=v:lua.vim.lsp.omnifunc
  autocmd BufEnter * lua require'completion'.on_attach()
  autocmd FileType sql let g:completion_trigger_character = ['.', '"']
augroup END

set completeopt=menuone,noinsert,noselect

let g:completion_confirm_key = "\<C-y>"
let g:completion_sorting = 'none'
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['exact', 'substring']
let g:completion_matching_ignore_case = 1
let g:completion_chain_complete_list = {
      \ 'sql': [
      \   {'complete_items': ['vim-dadbod-completion']},
      \   {'mode': '<c-n>'},
      \],
      \ 'default': [
      \    {'complete_items': ['lsp']},
      \    {'mode': '<c-n>'},
      \  ]}

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction


function s:tab_completion() abort
   let snippet = snippets#check()
   if !empty(snippet)
     return snippets#expand(snippet)
   endif

  if pumvisible()
    return "\<C-n>"
  endif

  if s:check_back_space()
    return "\<TAB>"
  endif

  return completion#trigger_completion()
endfunction

inoremap <silent><expr> <TAB> <sid>tab_completion()

imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

imap <c-j> <cmd>lua require'source'.prevCompletion()<CR>
imap <c-k> <cmd>lua require'source'.nextCompletion()<CR>

nmap <leader>ld <cmd>lua vim.lsp.buf.definition()<CR>
nmap <leader>lc <cmd>lua vim.lsp.buf.declaration()<CR>
nmap <leader>lg <cmd>lua vim.lsp.buf.implementation()<CR>
nmap <leader>lu <cmd>lua vim.lsp.buf.references()<CR>
nmap <leader>lr <cmd>lua vim.lsp.buf.rename()<CR>
nmap <leader>lh <cmd>lua vim.lsp.buf.hover()<CR>
nmap <leader>lf <cmd>lua vim.lsp.buf.formatting()<CR>
nmap <leader>la <cmd>lua vim.lsp.buf.code_action()<CR>
vmap <leader>la <cmd>lua vim.lsp.buf.code_action()<CR>

set wildoptions=pum
set wildignore=*.o,*.obj,*~                                                     "stuff to ignore when tab completing
set wildignore+=*.git*
set wildignore+=*.meteor*
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*mypy_cache*
set wildignore+=*__pycache__*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules*
set wildignore+=**/node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
