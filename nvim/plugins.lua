-- defining plugins
require("packer").startup {
    function()
        use "wbthomason/packer.nvim"

        -- LSP & CMP
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-vsnip"
        use "hrsh7th/vim-vsnip"

        -- dev tools
        use "jiangmiao/auto-pairs"
        use "alvan/vim-closetag"
        use "tpope/vim-commentary"
        use "tpope/vim-repeat"
        use "tpope/vim-fugitive"
        use "airblade/vim-gitgutter"
        use {"calebsmith/vim-lambdify", opt = true, ft = {"python", "haskell"}}
        use {"mattn/emmet-vim", opt = true, ft = {"html", "css", "php"}}

        -- appearance
        use "sheerun/vim-polyglot"
        use "ryanoasis/vim-devicons"
        use "nvim-lualine/lualine.nvim"
        use "lukas-reineke/indent-blankline.nvim"
        use {"rrethy/vim-hexokinase", run = "make hexokinase"}

        -- misc
        use "vimwiki/vimwiki"
        use "junegunn/fzf.vim"
        use "mhinz/vim-startify"
        use "powerman/vim-plugin-AnsiEsc"
    end
}

-- custom colors for lualine
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

-- custom filename module for lualine
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

    vim.cmd("hi! lualine_filename_status guifg=" .. fg .. " guibg=" .. bg .. " gui=" .. style)
    return "%t %m"
end

-- Setup lualine
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

-- Setup nvim-lsp (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
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
    require("lspconfig")[i].setup {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
end

-- Setup nvim-cmp (https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion)
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    mapping = {
        ["<tab>"]   = cmp.mapping.select_next_item(),
        ["<s-tab>"] = cmp.mapping.select_prev_item(),
        ["<down>"]  = cmp.mapping.scroll_docs(2),
        ["<up>"]    = cmp.mapping.scroll_docs(-2),
        ["<c-space>"] = cmp.mapping.complete(),
        ["<CR>"]    = cmp.mapping.confirm({select = false}),
        ["<C-y>"]   = cmp.config.disable,
        ["<C-e>"]   = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
    },

    sources = cmp.config.sources({
        {name = "nvim_lsp"},
        {name = "vsnip"},
        {name = "path"},
    })
})
