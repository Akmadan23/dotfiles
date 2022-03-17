-- defining plugins
require("packer").startup {
    function(use)
        use "wbthomason/packer.nvim"

        -- LSP & CMP
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-buffer"
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
        use {"mattn/emmet-vim", ft = {"html", "css", "php"}}

        -- appearance
        use "sheerun/vim-polyglot"
        use "rrethy/vim-hexokinase"
        use "ryanoasis/vim-devicons"
        use "nvim-lualine/lualine.nvim"
        use "powerman/vim-plugin-AnsiEsc"
        use "lukas-reineke/indent-blankline.nvim"

        -- utilities
        use "vimwiki/vimwiki"
        use "junegunn/fzf.vim"
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

-- Setup lualine
require("lualine").setup {
    options = {
        section_separators      = {left = "", right = ""},
        component_separators    = {left = "", right = ""},
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
        lualine_b = {"branch", "diff", {"diagnostics", sources = {"nvim_lsp"}}},
        lualine_c = {{"filename", symbols = {modified = " +", readonly = " -"}}},
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

-- Setup nvim-cmp
local cmp = require("cmp")

cmp.setup {
    mapping = {
        ["<tab>"]   = cmp.mapping.select_next_item(),
        ["<s-tab>"] = cmp.mapping.select_prev_item(),
        ["<down>"]  = cmp.mapping.scroll_docs(2),
        ["<up>"]    = cmp.mapping.scroll_docs(-2),
        ["<cr>"]    = cmp.mapping.confirm(),
        ["<c-e>"]   = cmp.mapping.close(),
        ["<c-y>"]   = cmp.config.disable,
    },

    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    sources = cmp.config.sources {
        {name = "nvim_lsp"},
        {name = "buffer"},
        {name = "vsnip"},
        {name = "path"},
    }
}

-- Defining language servers (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
local srv = {
    "vimls",
    "jdtls",
    "bashls",
    "texlab",
    "clangd",
    "phpactor",
    "emmet_ls",
    "sumneko_lua",
    "rust_analyzer",
    "jedi_language_server",
}

-- Enabling completion capabilities
local cap = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup nvim-lsp
for _, i in ipairs(srv) do
    require("lspconfig")[i].setup {
        capabilities = cap
    }
end
