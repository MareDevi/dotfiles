syntax on " 打开语法高亮 

set smartindent " 智能对齐
set confirm " 处理未保存与制度文件时弹出确认
set number " 显示行号
set wrap "设置自动折行
set autochdir " 自动切换工作目录
set termguicolors
set tabstop=4 " 设置tab键宽度
set encoding=UTF-8 " 设置编码
set softtabstop=4 " 设置Tab键空格数
set shiftwidth=4 " 设置缩进为4
set mouse=a " 启用鼠标
set laststatus=2    " 始终显示状态栏
let g:airline#extensions#tabline#enabled=1    " 开启 tab 栏
let g:airline_powerline_fonts=1

call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/tagbar'
Plug 'mhinz/vim-startify'
call plug#end()

let ayucolor="light"  
" for light version of theme
colorscheme nord "ayu

" 配置Nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
" ss快速移动
nmap ss <Plug>(easymotion-s2)
" 配置Tagbar
nmap <C-u> :TagbarToggle<CR>
" airline快捷键
nnoremap <C-d> :bn<CR>

" COC Tab键自动补全
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
