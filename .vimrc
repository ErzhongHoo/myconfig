"快捷键:<F2>ino编译、<F1>ino烧录、<F5>py运行、<F8>md预览
"显示行号
set number

"语法高亮
syntax on

"显示下划线 set cursorline

"搜索结果高亮显示(hight line search)
se hlsearch

"动态显示搜索结果
set incsearch

"搜索结果智能大小写（搜索大写只能搜索大写，搜索小写，大小写都显示）
set smartcase

"搜索结束后，高亮显示关闭(快捷键)：(<LEADER>默认为\（反斜杠))
noremap <LEADER><CR> :nohlsearch<CR>

set showmode

"在窗口下方展示当前执行的命令
set showcmd

"使用鼠标

" 普通模式
"v 可视模式
"i 插入模式
"c 命令行模式
"h 在帮助文件里，以上所有的模式
"a 以上所有的模式
set mouse=a

set t_Co=256

filetype indent on

set autoindent

set showmatch

"高亮显示搜索
set hlsearch

"自动换行(不超过当前窗口大小)
set wrap"

"ESC快捷键为jk
imap jk <Esc>
imap JK <Esc>

"中文括号改成英文括号,中文冒号改成英文冒号,书引号改成单引号,小括号修改
imap （ (
imap ） )
imap ： :
"imap 《 <
"imap 》 >
imap …… ^
imap ” "
imap × *
imap —— _
imap ， ,

"删除键可以删除到上一行
set backspace=2

"设置<tab>为四个空格
set ts=4
set expandtab
set autoindent

"按<F5>保存文件，识别文件类型，并运行
map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
elseif &filetype == 'python'
            exec "!time python %"
elseif &filetype == 'html'
            exec "!firefox % &"
elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
endif
    endfunc

"############################插件################################
call plug#begin('~/.vim/plugged')

"vimtex
"Plug 'lervag/vimtex'
"let g:tex_flavor='latex'
"let g:vimtex_view_method='zathura'
"let g:vimtex_quickfix_mode=0
"set conceallevel=1
"let g:tex_conceal='abdmg'

"vimtex-live-preview
"Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"let g:livepreview_previewer = '/usr/bin/chromium'
"nmap <F7> :LLPStartPreview<CR>

"vim-markdown-preview
Plug 'iamcco/markdown-preview.vim'
Plug 'iamcco/mathjax-support-for-mkdp'
"设置浏览文件工具
let g:mkdp_path_to_chrome = "/usr/bin/chromium"
nmap <silent> <F8> <Plug>MarkdownPreview        " 普通模式
"让所有文件都可以使用markdownpreview预览
let g:mkdp_command_for_global = 1
autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap ,h ====<Spacd><++><Esc>F=hi
autocmd Filetype markdown inoremap ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,5 #####<Space><Enter><++><Esc>kA


"vim-table-mode
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner = '|'
let g:table_mode_border=0
let g:table_mode_fillchar=' '
"表格自动对齐
function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
    \ <SID>isAtStartOfLine('\|\|') ?
    \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
    \ <SID>isAtStartOfLine('__') ?
    \ '<c-o>:silent! TableModeDisable<cr>' : '__'


"Ultisnips
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = ',t'
let g:UltiSnipsJumpForwardTrigger = ',t' 
let g:UltiSnipsJumpBackwardTrigger = 's,t' 
let g:UltiSnipsSnippetDirectories=["~/.vim/plugged/ultisnips/Ultisnips/"]
let g:UltiSnipsEditSplit="vertical"

"vimWiki
Plug 'vimwiki/vimwiki'
"vimwiki支持markdown语法
"let g:vimwiki_list = [ {"path": "~/vimwiki/",
                        \ 'syntas': "markdown", 'ext': '.md'}]

"calendar.vim
Plug 'itchyny/calendar.vim'
let g:vimwiki_use_calendar = 1
let g:calendar_diary = "~/Calendar"  " 设置日记的存储路径
let g:calendar_week_number=1

Plug 'sudar/vim-arduino-syntax'

Plug 'stevearc/vim-arduino'

call plug#end()

"#####################插件安装完成#########################
"
    
nnoremap <F1>  <Esc>:w<CR>:!arduino --upload %<CR>
nnoremap <F2>  <Esc>:w<CR>:!arduino --verify %<CR>
