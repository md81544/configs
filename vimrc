set nocompatible              " be iMproved, required
syntax on

filetype plugin indent on

" disable YCM
"let g:loaded_youcompleteme = 1
" Prevent YCM hijacking Up/Down arrow keys
let g:ycm_key_list_select_completion   = ['<Tab>']
let g:ycm_key_list_previous_completion = ['<S-Tab>']
"+=============================================================
" Plugins
" disable YouCompleteMe and other plugins if not Linux
let g:pathogen_blacklist = []
if system('archcode') !~ "linux"
    call add(g:pathogen_blacklist, 'YouCompleteMe')
endif


call pathogen#infect()

"Information on the following setting can be found with
":help set
set t_Co=256
set tabstop=4
set expandtab
set autoindent
set shiftwidth=4  "this is the level of autoindent, adjust to taste
set ruler
set number
set backspace=indent,eol,start
set visualbell
set nowrap
set autowrite
set ignorecase
set smartcase
set tags=tags;
let Tlist_Show_Menu=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Compact_Format=1
let g:Tlist_WinWidth=60
let g:netrw_banner=0

hi MatchParen cterm=bold ctermbg=none ctermfg=white
hi TabLine cterm=none ctermbg=none ctermfg=DarkGreen
hi TabLineSel cterm=none ctermbg=none ctermfg=yellow
hi LineNr ctermfg=red

" C/C++ syntax colour changes
hi cppExceptions ctermfg=green
hi cppStatement  ctermfg=green
hi cStatement    ctermfg=green
hi cConditional  ctermfg=green
hi cInclude      ctermfg=green
hi cIncluded     ctermfg=green
hi cTodo         ctermfg=black ctermbg=green

set mouse=a
set gcr=a:blinkon0
set colorcolumn=80
highlight ColorColumn ctermbg=0

" prevent comment continuation
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

set list listchars=tab:>-,trail:*

map <C-K> :pyf ~/bin/bde-format.py<cr>
map <C-K> <C-o>:pyf ~/bin/bde-format.py<cr>

" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" recreate tags file with F5
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map <F6> :TlistToggle<CR>
vmap <F6> <Esc>:TlistToggle<CR>

map <F7> :if exists("g:syntax_on") <Bar>
            \   syntax off <Bar>
            \ else <Bar>
            \   syntax enable <Bar>
            \ endif <CR>

"\o browse for file. Starts in the pwd of the current file.
map <leader>o :cd %:p:h<CR>:tabe<CR>:E<CR>

" toggles paste mode
set pastetoggle=<leader>p

"\f shows full filename and path
map <leader>f 1<C-G>

"\<Tab>
imap <leader><Tab> <Esc>i<Tab>

" toggles line numbering
map  <leader># :set invnumber<CR>
imap <leader># <C-o>:set invnumber<CR>

"\w removes any trailing whitespace on a line
map <leader>w :s/\s\+$//<CR>

" go to definition/declaration
map <F12> :YcmCompleter GoToDefinition<CR>
" Shift-F12:
map <c-[>[24;2~ :YcmCompleter GoToDeclaration<CR>

" Tab in normal mode shifts lines around
map  <Tab> >>
map  <S-Tab> <<
" Shift tab unindents in insert mode
imap <S-Tab> <C-o><<


if has("gui_running")
    map  <silent>  <S-Insert>  "+p
    imap <silent>  <S-Insert>  <Esc>"+pa
endif

" Get out of visual select quicker than just pressing Esc
" (will overwrite mark z)
vmap <space> <esc>mz<left><right>`z

"YouCompleteMe
"-----------------------------------
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 1
let g:ycm_max_diagnostics_to_display = 1000
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1

"this is experimental, these should be default settings!
let g:ycm_auto_trigger = 1
let g:ycm_semantic_triggers =  {
            \   'c' : ['->', '.'],
            \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
            \             're!\[.*\]\s'],
            \   'ocaml' : ['.', '#'],
            \   'cpp,objcpp' : ['->', '.', '::'],
            \   'perl' : ['->'],
            \   'php' : ['->', '::'],
            \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
            \   'ruby' : ['.', '::'],
            \   'lua' : ['.', ':'],
            \   'erlang' : [':'],
            \ }
let g:ycm_path_to_python_interpreter="/opt/bb/bin/python"

"diagmode of ycm
"nnoremap <F3> <Esc> :YcmDiags<CR>
"nnoremap <F2> :YcmCompleter FixIt<CR>
"nnoremap <F7> :YcmCompleter GoToDefinition<CR>
"nnoremap <F8> :YcmCompleter GoToDeclaration<CR>

"always show gutter aka sign column, and clear its colour
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
highlight clear SignColumn

"Only enable ycm for certain types of file
let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1, 'python': 1}

highlight YcmErrorSection ctermfg=red ctermbg=0  guifg=red guibg=white

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

inoremap <Down>     <Esc><Down>
inoremap <Up>       <Esc><Up>

