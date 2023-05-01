-- Define packer's startup function
return function(use)
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"
    use "lewis6991/impatient.nvim"
    use "nvim-tree/nvim-web-devicons"

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        config = require("configs.lspconfig")
    }

    -- Completion
    use {
        "hrsh7th/nvim-cmp",
        config = require("configs.cmp"),

        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        }
    }

    -- Snippets
    use {
        "L3MON4D3/LuaSnip",
        tag = "v1.*",
        config = require("configs.luasnips")
    }

    -- JDTLS
    use {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
        config = require("configs.jdtls")
    }

    -- Rust tools
    use {
        "simrat39/rust-tools.nvim",
        ft = { "rust" },

        config = function()
            require("rust-tools").setup()
        end
    }

    -- Crates
    use {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },

        config = function()
            require("crates").setup()
        end
    }

    -- Trouble
    use {
        "folke/trouble.nvim",

        config = function()
            require("trouble").setup {
                indent_lines = false,
                auto_close = true
            }
        end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = require("configs.treesitter"),

        requires = {
            "RRethy/nvim-treesitter-endwise",
            "windwp/nvim-ts-autotag",
        }
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.*",
        config = require("configs.telescope"),

        requires = {
            "debugloop/telescope-undo.nvim"
        }
    }

    -- Lualine
    use {
        "nvim-lualine/lualine.nvim",
        config = require("configs.lualine")
    }

    -- Highlight colors
    use {
        "brenoprata10/nvim-highlight-colors",

        config = function()
            require("nvim-highlight-colors").setup {
                enable_named_colors = false,
                render = "background"
            }
        end
    }

    -- Indent blankline
    use {
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
                }
            }
        end
    }

    -- Git signs
    use {
        "lewis6991/gitsigns.nvim",

        config = function()
            require("gitsigns").setup()
        end
    }

    -- Comment
    use {
        "numToStr/Comment.nvim",

        config = function()
            require("Comment").setup {
                ignore = "^$"
            }
        end
    }

    -- Ultimate autopair
    use {
        "altermo/ultimate-autopair.nvim",

        config = function()
            require("ultimate-autopair").setup {
                cr = {
                    addsemi = false
                }
            }
        end
    }
end
