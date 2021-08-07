let mapleader=" "
call plug#begin('~/.config/nvim/plugged')
  Plug 'mfussenegger/nvim-jdtls'
  Plug 'mfussenegger/nvim-dap'
  Plug 'dracula/vim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'hrsh7th/nvim-compe'
  Plug 'onsails/lspkind-nvim'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'nvim-telescope/telescope-dap.nvim'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'preservim/nerdtree'
  Plug 'neovim/nvim-lspconfig'
  Plug 'tpope/vim-fugitive'
  Plug 'ryanoasis/vim-devicons'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'diepm/vim-rest-console'
  Plug 'mattn/emmet-vim'
  Plug 'vimwiki/vimwiki'
  Plug 'tpope/vim-surround'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'vim-test/vim-test'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
call plug#end()

set syntax=yes
set number relativenumber
set nohlsearch incsearch
set colorcolumn=80
set splitright
set splitbelow
set expandtab
set autoindent
set cindent
set softtabstop=2 shiftwidth=2
set background=dark
colorscheme dracula

nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

nnoremap Y y$
nnoremap n nzz
nnoremap N Nzz

inoremap jk <Esc>
inoremap kj <Esc>

" disable backspace and arrow keys
inoremap <BS> <Nop>
nnoremap <BS> <Nop>
vnoremap <BS> <Nop>

nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>

nnoremap <Right> :echo "No left for you!"<CR>
vnoremap <Right> :<C-u>echo "No left for you!"<CR>
inoremap <Right> <C-o>:echo "No left for you!"<CR>

nnoremap <Up> :echo "No left for you!"<CR>
vnoremap <Up> :<C-u>echo "No left for you!"<CR>
inoremap <Up> <C-o>:echo "No left for you!"<CR>

nnoremap <Down> :echo "No left for you!"<CR>
vnoremap <Down> :<C-u>echo "No left for you!"<CR>
inoremap <Down> <C-o>:echo "No left for you!"<CR>

nnoremap Q :q!<CR>
nnoremap W :w!<CR>
nnoremap <silent><leader>so :source $HOME/.config/nvim/init.vim<CR>

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=150}
augroup END

" java lsp
augroup lsp
   au!
   au FileType java lua require'lsp.java.setup'.setup()
augroup end

" typescript lsp
augroup typscipt
  au!
  au FileType typescript,javascript lua require("lsp.typescript.setup") 
  au FileType typescript,javascript lua require("lsp.linter.setup") 
augroup end

" Telescope
nnoremap <leader><leader> <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" remap split selection in telescope window
lua << EOF

local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<c-s>"] = actions.select_vertical,
        ["<c-x>"] = actions.select_horizontal,
        },
      n = {
        ["<c-s>"] = actions.select_vertical,
        ["<c-x>"] = actions.select_horizontal,
        },
      }
    }
  }

EOF

" Dap setup
nnoremap <silent><leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent><S-k> :lua require'dap'.step_out()<CR>
nnoremap <silent><S-l> :lua require'dap'.step_into()<CR>
nnoremap <silent><S-j> :lua require'dap'.step_over()<CR>
nnoremap <silent><leader>ds :lua require'dap'.stop()<CR>
nnoremap <silent><leader>dn :lua require'dap'.continue()<CR>
nnoremap <silent><leader>dk :lua require'dap'.up()<CR>
nnoremap <silent><leader>dj :lua require'dap'.down()<CR>
nnoremap <silent><leader>d_ :lua require'dap'.run_last()<CR>
nnoremap <silent><leader>di :lua require'dap.ui.variables'.hover(function () return vim.fn.expand("<cexpr>") end)<CR>
vnoremap <silent><leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <silent><leader>d? :lua require'dap.ui.variables'.scopes()<CR>

nnoremap <silent><leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l

" Plug 'nvim-telescope/telescope-dap.nvim'
lua << EOF
require('telescope').setup()
require('telescope').load_extension('dap')
EOF
nnoremap <leader>df :Telescope dap frames<CR>
nnoremap <leader>dc :Telescope dap commands<CR>
nnoremap <leader>db :Telescope dap list_breakpoints<CR>

lua << EOF
local dap = require('dap')
dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
}
EOF

" NERD Tree
nnoremap <leader>tt :NERDTreeToggle<CR>

" Compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true
  }
}
EOF

" Lua line
lua << EOF
require('lualine').setup()
EOF

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
" nvim-dap-virtual-text
let g:dap_virtual_text = v:true

" dap-ui
" lua require('dapui').setup()
" nnoremap <silent><leader>dq :lua require('dapui').toggle()<CR>

" vim-test
let test#java#runner = 'gradletest'

tmap <C-o> <C-\><C-n>

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" let g:syntastic_java_checkers = ['checkstyle']
" let g:syntastic_java_checkstyle_classpath = './lsp/java/checkstyle-8.4-all.jar'
" let g:syntastic_java_checkstyle_conf_file = './lsp/java/checkstyle.xml'
" 
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

