let mapleader=" "
call plug#begin('~/.config/nvim/plugged')
  Plug 'mfussenegger/nvim-jdtls'
  Plug 'mfussenegger/nvim-dap'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'hrsh7th/nvim-compe'
  Plug 'tpope/vim-fugitive'
  Plug 'onsails/lspkind-nvim'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'nvim-telescope/telescope-dap.nvim'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'preservim/nerdtree'
  Plug 'neovim/nvim-lspconfig'
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
  Plug 'NTBBloodbath/rest.nvim'
  Plug 'rktjmp/lush.nvim'
  "Plug 'joshdick/onedark.vim'
  "Plug 'ellisonleao/gruvbox.nvim'
  "Plug 'ayu-theme/ayu-vim'
  Plug 'lifepillar/vim-solarized8'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'towolf/vim-helm'
  Plug 'mtdl9/vim-log-highlighting'
  Plug 'karb94/neoscroll.nvim'
  Plug '907th/vim-auto-save'
"  Plug 'vim-syntastic/syntastic'
call plug#end()

set termguicolors
set signcolumn=yes
set number relativenumber
set nohlsearch incsearch
set splitright
set splitbelow
set expandtab
set autoindent
set cindent
set softtabstop=4 shiftwidth=4
syntax on " This is required
hi Normal ctermbg=none
highlight NonText ctermbg=none

set background=dark
"let ayucolor="dark"
"colorscheme gruvbox
"colorscheme onedark
colorscheme solarized8

let g:auto_save = 1  " enable AutoSave on Vim startup

inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [ []<Esc>i
inoremap < <><Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i

nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

nnoremap <leader>y "*y
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

augroup rust
   au!
   au FileType rust lua require("lsp.rust.setup")
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
nnoremap <silent><leader>di :lua require('dap.ui.widgets').hover()<CR>
vnoremap <silent><leader>di :lua require('dap.ui.widgets').hover()<CR>
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

lua << EOF
require("rest-nvim").setup({
    -- Open request results in a horizontal split
    result_split_horizontal = false,
    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = false,
    -- Highlight request on run
    highlight = {
        enabled = true,
        timeout = 150,
    },
    -- Jump to request line on run
    jump_to_request = false,
    })


local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.http = {
  install_info = {
    url = "https://github.com/NTBBloodbath/tree-sitter-http",
    files = { "src/parser.c" },
    branch = "main",
  },
}

EOF

nnoremap <leader>ht :lua require('rest-nvim').run()<CR>

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

lua << EOF
require'lspconfig'.groovyls.setup{
    cmd = { "java", "-jar", "/home/kgarapati/groovy-language-server/build/libs/groovy-language-server-all.jar" }
}
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
" let g:syntastic_java_checkstyle_classpath = '/home/kgarapati/.config/nvim/lsp/java/checkstyle-8.14-all.jar'
" let g:syntastic_java_checkstyle_conf_file = '/home/kgarapati/.config/nvim/lsp/java/checkstyle.xml'

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" fold java imports
lua << EOF
function foldJavaImports()
    local start_index, end_index = 0, 0
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for index,line in pairs(lines) do
        if string.find(line, 'import ') then
            start_index = index - 1
            break
        end
    end
    for index,line in pairs(lines) do
        if string.find(line, 'import ') then
            end_index = index - 1
        end
    end
    local distance  = end_index - start_index
    if (distance > 5) then
        vim.cmd('normal gg' .. start_index .. 'jzf' .. distance .. 'j')
    end
end
EOF

"augroup foldJavaImport
"   au!
"   au FileType java lua foldJavaImports()
"augroup end
"
lua require('rust-tools').setup({})

" presentation mode
noremap <Left> :silent bp<CR> :redraw!<CR>
noremap <Right> :silent bn<CR> :redraw!<CR>
nmap <F5> :set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>
nmap <F2> :call DisplayPresentationBoundaries()<CR>
nmap <F3> :call FindExecuteCommand()<CR>

" jump to slides
nmap <F9> :call JumpFirstBuffer()<CR> :redraw!<CR>
nmap <F10> :call JumpSecondToLastBuffer()<CR> :redraw!<CR>
nmap <F11> :call JumpLastBuffer()<CR> :redraw!<CR>

let g:presentationBoundsDisplayed = 0
function! DisplayPresentationBoundaries()
  if g:presentationBoundsDisplayed
    match
    set colorcolumn=0
    let g:presentationBoundsDisplayed = 0
  else
    highlight lastoflines ctermbg=darkred guibg=darkred
    match lastoflines /\%23l/
    set colorcolumn=80
    let g:presentationBoundsDisplayed = 1
  endif
endfunction

function! FindExecuteCommand()
  let line = search('\S*!'.'!:.*')
  if line > 0
    let command = substitute(getline(line), "\S*!"."!:*", "", "")
    execute "silent !". command
    execute "normal gg0"
    redraw
  endif
endfunction

function! JumpFirstBuffer()
  execute "buffer 1"
endfunction

function! JumpSecondToLastBuffer()
  execute "buffer " . (len(Buffers()) - 1)
endfunction

function! JumpLastBuffer()
  execute "buffer " . len(Buffers())
endfunction

function! Buffers()
  let l:buffers = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  return l:buffers
endfunction

lua require('neoscroll').setup()

