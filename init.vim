"                    
"                 .-~~~~~~~~~-._       _.-~~~~~~~~~-.
"             __.'welcome to   ~.   .~              `.__
"           .'//     My blog     \./ ☞ codeshen.com☜   \\`.
"         .'//                     |                     \\`.
"       .'// .-~"""""""~~~~-._     |     _,-~~~~"""""""~-. \\`.
"     .'//.-"                 `-.  |  .-'                 "-.\\`.
"   .'//______.============-..   \ | /   ..-============.______\\`.
" .'______________________________\|/______________________________`.
"
"     _ _    __     ___                    
"    | (_)_ _\ \   / (_)_ __ ___  _ __ ___ 
" _  | | | '_ \ \ / /| | '_ ` _ \| '__/ __|
"| |_| | | | | \ V / | | | | | | | | | (__ 
" \___/|_|_| |_|\_/  |_|_| |_| |_|_|  \___|
"                                          
" Author: JinsX5
"
" 关闭vi兼容模式
set nocompatible
" 打开文件类型检测
filetype on
filetype indent on    "缩进文件检测
filetype plugin on    "特定类型文件检测
" 相当于集合上面三条指令
filetype plugin indent on

" 空格键成为leader键
let mapleader=" "
" syntax代码高亮
syntax on
" hi Visual term=reverse cterm=reverse guibg=Lightblue
hi Visual guifg=#000000 guibg=#FFFFFF gui=none


set mouse=
set encoding=utf-8

let &t_ut=''

" tab缩进设置
if has("autocmd")
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
endif

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set textwidth=79
set expandtab

set autoindent
set fileformat=unix
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5
set tw=0
set indentexpr=
set backspace=indent,eol,start
"Enable folding
set foldmethod=indent
set foldlevel=99
"通过空格键快速打开和关闭折叠
noremap <space> za

"F3快捷键,粘贴复制缩进开关
set pastetoggle=<F3>
"行号，加前缀no取消设置
set number
set relativenumber
"下行线
set cursorline
"窗口换行
set wrap
"显示输入
set showcmd
"menu补全指令
"set wildmenu

set scrolloff=5
"/搜索结果高亮"
set hlsearch
exec "nohlsearch"
"搜索过程高亮"
set incsearch
"搜索忽略大小写"
set ignorecase
"智能大小写"
set smartcase
"F3快捷键,粘贴复制缩进开关

"noremap改键
noremap = nzz
noremap - Nzz
noremap <LEADER><CR> :nohlsearch<CR>

noremap s <nop>
noremap S :w!<CR>
noremap Q :q!<CR>
noremap D ggdD<CR>
noremap R :source $MYVIMRC<CR>
noremap ; :

" Open the vimrc file anytime
noremap <LEADER>c :e ~/.config/nvim/init.vim<CR>

" ===
" === Markdown Settings
" ===
" Snippets
source ~/.config/nvim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell

"通过命令fcitx自动控制vim的输入状态
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set timeoutlen=150
autocmd InsertLeave * call Fcitx2en()
"去掉注释实现:进入插入模式自动启用输入法
"autocmd InsertEnter * call Fcitx2zh()


"compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		CocCommand flutter.run
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc


" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

" vim-theme
Plug 'ajmwagar/vim-deus'
Plug 'https://github.com/joshdick/onedark.vim'

"插件列表：airline-下方状态栏
Plug 'vim-airline/vim-airline'

"multiple cursors 多操作
Plug 'terryma/vim-multiple-cursors'

" Snippets  https://github.com/honza/vim-snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"===
"===Markdown-preview
"===
" If you don't have nodejs and yarn
" use pre build
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" List ends here. Plugins become visible to Vim after this call.

call plug#end()

"Plug Settings"

"===
"=== vim-theme
"===

"deus: https://github.com/ajmwagar/vim-deus/issues
color deus
syntax on
hi Normal cterm=NONE ctermbg=NONE

" ===
" === multi_cursor 
" ===

" https://github.com/terryma/vim-multiple-cursors

" Mapping
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" ===
" === markdown-preview
" ===

" https://github.com/iamcco/markdown-preview.nvim

nmap <C-s> <Plug>MarkdownPreview
nmap <C-d> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'google-chrome-stable'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {}
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" ===
" === UltiSnips
" ===

" https://github.com/SirVer/ultisnips

let g:tex_flavor = "latex"
inoremap <c-n> <nop>
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']
silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>
" Solve extreme insert-mode lag on macOS (by disabling autotrigger)
augroup ultisnips_no_auto_expansion
    au!
        au VimEnter * au! UltiSnips_AutoTrigger
        augroup END
