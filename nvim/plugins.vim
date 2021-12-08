call plug#begin('~/.config/nvim/autoload/plugged')
    " LSP Completion
    Plug 'neovim/nvim-lspconfig'
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

    " dev tools
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'calebsmith/vim-lambdify'
    Plug 'mattn/emmet-vim'

    " appearance
    Plug 'rrethy/vim-hexokinase', {'do': 'make hexokinase'}
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot'

    " misc
    Plug 'vimwiki/vimwiki'
    Plug 'mattn/calendar-vim'
    Plug 'mhinz/vim-startify'
    Plug 'junegunn/fzf.vim'
    Plug 'powerman/vim-plugin-AnsiEsc'
call plug#end()

lua << EOF
local colors = {
    black   = "#232526",
    magenta = "#F92672",
    green   = "#A6E22E",
    yellow  = "#E6DB74",
    blue    = "#66D9EF",
    orange  = "#FD971F",
    purple  = "#AE81FF",
    white   = "#F8F8F0",
    gray    = "#465457",
}

local function filename_status()
    -- default
    local bg = colors.gray
    local fg = colors.white
    local style = "none"

    if vim.bo.modified then -- unsaved
        -- fg = colors.orange
        style = "bold"
    elseif not vim.bo.modifiable or vim.bo.readonly then -- readonly
        style = "italic"
    end

    vim.cmd("hi! lualine_filename_status guifg=" .. fg .. " guibg=" .. bg ..  " gui=" .. style)
    return "%t %m"
end

require("lualine").setup {
    options = {
        -- section_separators = {left = "", right = ""},
        section_separators = {},
        component_separators = {left = "●", right = "●"},
        theme = {
            normal = {
                a = {fg = colors.black, bg = colors.yellow, gui = "bold"},
                b = {fg = colors.white, bg = colors.black},
                c = {fg = colors.white, bg = colors.gray}
            },

            insert      = {a = {fg = colors.black,  bg = colors.blue,       gui = "bold"}},
            visual      = {a = {fg = colors.black,  bg = colors.green,      gui = "bold"}},
            replace     = {a = {fg = colors.black,  bg = colors.magenta,    gui = "bold"}},
            command     = {a = {fg = colors.black,  bg = colors.orange,     gui = "bold"}},
            terminal    = {a = {fg = colors.black,  bg = colors.purple,     gui = "bold"}},
            inactive    = {c = {fg = colors.yellow, bg = colors.gray}}
        }
    },

    sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff", {"diagnostics", sources = {"nvim_lsp", "coc"}}},
        -- lualine_c = {"filename"},
        lualine_c = {{filename_status, color = "lualine_filename_status"}},
        lualine_x = {"filetype"},
        lualine_y = {"encoding"},
        lualine_z = {"progress", "location"}
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"filetype", "location"},
        lualine_y = {},
        lualine_z = {}
    }
}

-- LSP (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
require('lualine').vimls.setup                  {}
require('lspconfig').vimls.setup                {}
require('lspconfig').texlab.setup               {}
require('lspconfig').clangd.setup               {}
require('lspconfig').phpactor.setup             {}
require('lspconfig').emmet_ls.setup             {}
require('lspconfig').rust_analyzer.setup        {}
require('lspconfig').jedi_language_server.setup {}
require('lspconfig').java_language_server.setup {}
EOF
