require("packer").startup {
    function()
        use "wbthomason/packer.nvim"
        use "neovim/nvim-lspconfig"
        use "ms-jpq/coq_nvim"
        use "ms-jpq/coq.artifacts"

        use "jiangmiao/auto-pairs"
        use "alvan/vim-closetag"
        use "tpope/vim-commentary"
        use "tpope/vim-repeat"
        use "tpope/vim-fugitive"
        use "airblade/vim-gitgutter"
        use "calebsmith/vim-lambdify"
        use "mattn/emmet-vim"

        use {"rrethy/vim-hexokinase", run = "make hexokinase"}
        use "lukas-reineke/indent-blankline.nvim"
        use "nvim-lualine/lualine.nvim"
        use "ryanoasis/vim-devicons"
        use "sheerun/vim-polyglot"

        use "vimwiki/vimwiki"
        use "mattn/calendar-vim"
        use "mhinz/vim-startify"
        use "junegunn/fzf.vim"
        use "powerman/vim-plugin-AnsiEsc"
    end
}

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
local srv = {
    "vimls",
    "bashls",
    "texlab",
    "clangd",
    "phpactor",
    "emmet_ls",
    "rust_analyzer",
    "jedi_language_server",
    "java_language_server",
}

for _, i in ipairs(srv) do
    require("lspconfig")[i].setup {}
end
