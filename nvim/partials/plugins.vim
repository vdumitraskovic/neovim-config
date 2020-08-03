function! s:packager_init() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
  call packager#add('kristijanhusak/vim-js-file-import', { 'do': 'npm install', 'type': 'opt' })
  call packager#add('fatih/vim-go', { 'do': ':GoInstallBinaries', 'type': 'opt' })
  call packager#add('vimwiki/vimwiki', { 'type': 'opt' })
  call packager#add('tpope/vim-commentary')
  call packager#add('tpope/vim-surround')
  call packager#add('tpope/vim-repeat')
  call packager#add('tpope/vim-fugitive')
  call packager#add('tpope/vim-sleuth')
  call packager#add('kristijanhusak/vim-dadbod')
  call packager#add('kristijanhusak/vim-dadbod-ui')
  call packager#add('lambdalisue/vim-backslash')
  call packager#add('lambdalisue/reword.vim')
  call packager#add('AndrewRadev/splitjoin.vim')
  call packager#add('airblade/vim-gitgutter')
  call packager#add('sheerun/vim-polyglot')
  call packager#add('junegunn/fzf', { 'do': './install --all && ln -sf $(pwd) ~/.fzf'})
  call packager#add('junegunn/fzf.vim')
  call packager#add('ludovicchabant/vim-gutentags')
  call packager#add('editorconfig/editorconfig-vim')
  call packager#add('andymass/vim-matchup')
  call packager#add('haya14busa/vim-asterisk')
  call packager#add('osyo-manga/vim-anzu')
  call packager#add('stefandtw/quickfix-reflector.vim')
  call packager#add('w0rp/ale')
  call packager#add('AndrewRadev/tagalong.vim')
  call packager#add('kristijanhusak/vim-create-pr')
  call packager#add('wakatime/vim-wakatime')
  call packager#add('arzg/vim-colors-xcode')
  call packager#add('gruvbox-community/gruvbox')
  call packager#add('voldikss/vim-floaterm')
  call packager#add('kyazdani42/nvim-web-devicons')
  call packager#add('kyazdani42/nvim-tree.lua')
  call packager#add('tmsvg/pear-tree')
  call packager#add('neovim/nvim-lsp')
  call packager#add('nvim-lua/completion-nvim')
  call packager#add('kristijanhusak/vim-dadbod-completion')
endfunction

let g:mapleader = ','                                                           "Change leader to a comma

command! -nargs=0 PackagerInstall call s:packager_init() | call packager#install()
command! -bang PackagerUpdate call s:packager_init() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call s:packager_init() | call packager#clean()
command! PackagerStatus call s:packager_init() | call packager#status()

augroup packager_filetype
  autocmd!
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact packadd vim-js-file-import
  autocmd FileType go packadd vim-go
  autocmd VimEnter * call feedkeys("\<C-w>w")
  autocmd FileType LuaTree call s:setup_luatree()
augroup END

function! s:setup_luatree() abort
  setlocal signcolumn=yes
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer> J :call search('[]')<CR>
  nnoremap <silent><buffer> K :call search('[]', 'b')<CR>
endfunction

" Better search status
nnoremap <silent><Leader><space> :AnzuClearSearchStatus<BAR>noh<CR>
nmap n <Plug>(anzu-n)zz
nmap N <Plug>(anzu-N)zz
map * <Plug>(asterisk-z*)<Plug>(anzu-update-search-status)
map # <Plug>(asterisk-z#)<Plug>(anzu-update-search-status)
map g* <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status)
map g# <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status)
nnoremap <silent><Leader>ww :unmap <Leader>ww<BAR>packadd vimwiki<BAR>VimwikiIndex<CR>

" Reformat and fix linting errors
nnoremap <Leader>R :ALEFix<CR>
nnoremap <silent>[e :ALEPrevious<CR>
nnoremap <silent>]e :ALENext<CR>

nnoremap <silent><Leader>G :FloatermNew --width=0.9 --height=0.9 lazygit<CR>

" Tree mappings
nnoremap <silent><Leader>n :LuaTreeToggle<CR>
nnoremap <silent><Leader>hf :LuaTreeFindFile<CR>

" Pear tree mappings
imap <BS> <Plug>(PearTreeBackspace)
imap <CR> <Plug>(PearTreeExpand)
imap <Esc> <Plug>(PearTreeFinishExpansion)

let g:lua_tree_bindings = {
    \ 'edit':        'o',
    \ 'edit_vsplit': 's',
    \ 'cd':          'C',
    \ }
let g:lua_tree_ignore = ['.git']
let g:lua_tree_icons = {
      \ 'default': '',
      \ 'git': {
      \   'unstaged': '✹',
      \ }}
let g:lua_tree_follow = 1
let g:lua_tree_auto_open = 1
let g:lua_tree_size = 40
let g:lua_tree_git_hl = 1

let g:ale_virtualtext_cursor = 1
let g:ale_linters = {'javascript': ['eslint']}                                  "Lint js with eslint
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}                       "Fix eslint errors
let g:ale_javascript_prettier_options = '--print-width 120'                     "Set max width to 120 chars for prettier
let g:ale_lint_delay = 400                                                      "Increase linting delay
let g:ale_sign_error = '✖'                                                      "Lint error sign
let g:ale_sign_warning = '⚠'                                                    "Lint warning sign

let g:jsx_ext_required = 1                                                      "Force jsx extension for jsx filetype
let g:javascript_plugin_jsdoc = 1                                               "Enable syntax highlighting for js doc blocks
let g:vim_markdown_conceal = 0                                                  "Disable concealing in markdown

let g:vimwiki_list = [{
      \ 'path': '~/Dropbox/vimwiki',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'
      \ }]

let g:matchup_matchparen_status_offscreen = 0                                   "Do not show offscreen closing match in statusline
let g:matchup_matchparen_nomode = "ivV\<c-v>"                                   "Enable matchup only in normal mode
let g:matchup_matchparen_deferred = 1                                           "Defer matchup highlights to allow better cursor movement performance

let g:db_ui_show_help = 0                                                       "Hide Press ? for help in dbui drawer
let g:db_ui_win_position = 'right'                                              "Open DBUI drawer on right
let g:db_ui_use_nerd_fonts = 1                                                  "Use nerd fonts for DBUI
let g:db_async = 1                                                              "Use async for dadbod

let g:js_file_import_use_fzf = 1                                                "Use FZF for js file import prompts

let g:db_ui_save_location = '~/Dropbox/dbui'                                    "Use dropbox as save location for dbui
let g:db_ui_tmp_query_location = '~/code/queries'                               "Save all dbui queries in this location

let g:floaterm_keymap_toggle = '<Leader>T'                                      "Mapping for toggling floaterm

let g:pear_tree_repeatable_expand = 0
let g:pear_tree_map_special_keys = 0
