return {
    { "nvim-lua/plenary.nvim",              lazy = true },
    { "nvim-tree/nvim-web-devicons",        lazy = true },
    { "folke/neodev.nvim", version = "*",   lazy = true },

    {   -- LSP
        "neovim/nvim-lspconfig",
        config = require("configs.lspconfig")
    },

    {   -- CMP
        "hrsh7th/nvim-cmp",
        cond = vim.bo.modifiable,
        config = require("configs.cmp"),

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        }
    },

    {   -- Snippets
        "L3MON4D3/LuaSnip",
        version = "v1.*",
        cond = vim.bo.modifiable,
        config = require("configs.luasnips")
    },

    {   -- JDTLS
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = require("configs.jdtls")
    },

    {   -- Rust tools
        "simrat39/rust-tools.nvim",
        ft = "rust",

        config = function()
            require("rust-tools").setup()
        end
    },

    {   -- Crates
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",

        config = function()
            require("crates").setup()
        end
    },

    {   -- Trouble
        "folke/trouble.nvim",

        config = function()
            require("trouble").setup {
                indent_lines = false,
                auto_close = true
            }
        end
    },

    {   -- Treesitter
        "nvim-treesitter/nvim-treesitter",
        config = require("configs.treesitter"),

        dependencies = {
            "RRethy/nvim-treesitter-endwise",
            "windwp/nvim-ts-autotag",
        }
    },

    {   -- Telescope
        "nvim-telescope/telescope.nvim",
        version = "0.1.*",
        config = require("configs.telescope"),

        dependencies = {
            "debugloop/telescope-undo.nvim"
        }
    },

    {   -- Nvim tree
        "nvim-tree/nvim-tree.lua",
        config = require("configs.nvim-tree")
    },

    {   -- Lualine
        "nvim-lualine/lualine.nvim",
        config = require("configs.lualine")
    },

    {   -- Highlight colors
        "brenoprata10/nvim-highlight-colors",

        config = function()
            require("nvim-highlight-colors").setup {
                enable_named_colors = false,
                render = "background"
            }
        end
    },

    {   -- Indent blankline
        "lukas-reineke/indent-blankline.nvim",

        config = function()
            require("indent_blankline").setup {
                char = "▏",
                indent_level                    = 10,
                max_indent_increase             = 2,
                show_trailing_blankline_indent  = false,
                show_first_indent_level         = true,

                filetype_exclude = {
                    "help",
                    "man",
                    "markdown",
                    "vimwiki",
                    "tex",
                    "text"
                }
            }
        end
    },

    {   -- Git signs
        "lewis6991/gitsigns.nvim",

        config = function()
            require("gitsigns").setup()
        end
    },

    {   -- Comment
        "numToStr/Comment.nvim",
        cond = vim.bo.modifiable,

        config = function()
            require("Comment").setup {
                ignore = "^$"
            }
        end
    },

    {   -- Autopairs
        "altermo/ultimate-autopair.nvim",
        cond = vim.bo.modifiable,
        -- commit = "b1cbb66",

        config = function()
            require("ultimate-autopair").setup {
                bs = {
                    overjump = false
                },

                cr = {
                    addsemi = false
                },
            }
        end
    },
}
