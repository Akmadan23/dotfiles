-- Define packer's startup function
local packer_startup = function(use)
    use "wbthomason/packer.nvim"

    -- LSP & CMP
    use {
        "neovim/nvim-lspconfig",

        requires = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "onsails/lspkind-nvim",
        },

        config = function()
            local cmp = require("cmp")

            -- Setup nvim-cmp
            cmp.setup {
                sources = cmp.config.sources {
                    { name = "nvim_lsp" },
                    { name = "path"     },
                    { name = "vsnip"    },
                    { name = "buffer"   },
                },

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
                    ["<cr>"]    = cmp.mapping.confirm(),
                    ["<c-e>"]   = cmp.mapping.close(),
                    ["<c-y>"]   = cmp.config.disable,
                },

                formatting = {
                    format = require("lspkind").cmp_format {
                        mode = "symbol_text"
                    }
                }
            }

            -- Language servers
            local srv = {
                "vimls",
                "nimls",
                "bashls",
                "texlab",
                "clangd",
                "phpactor",
                "sumneko_lua",
                "rust_analyzer",
                "quick_lint_js",
                "jedi_language_server",
            }

            -- Enable completion capabilities
            local cap = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

            -- Suppress warning "Undefined global `vim`" in lua
            local lua_settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }

            -- Setup nvim-lsp
            for _, i in pairs(srv) do
                require("lspconfig")[i].setup {
                    capabilities = cap,
                    settings = (i == "sumneko_lua") and lua_settings or nil
                }
            end
        end
    }

    -- JDTLS
    use {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },

        config = function()
            require("jdtls").start_or_attach {
                -- The command that starts the language server
                -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xms1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

                    -- the following options must be modified depending on the system
                    "-jar", "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
                    "-configuration", "/usr/share/java/jdtls/config_linux",
                    "-data", vim.fn.expand("%:p:h:h")
                },

                -- This is the default if not provided, you can remove it. Or adjust as needed.
                -- One dedicated LSP server & client will be started per unique root_dir
                root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew" },
            }
        end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = { "windwp/nvim-ts-autotag" },

        config = function()
            -- Assign parsers to unsupported filetypes
            local ft_parser = require("nvim-treesitter.parsers").filetype_to_parsername
            ft_parser.zsh = "bash"

            require("nvim-treesitter.configs").setup {
                highlight   = { enable = true },
                autotag     = { enable = true },

                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "latex",
                    "lua",
                    "make",
                    "php",
                    "python",
                    "ruby",
                    "rust",
                    "sql",
                    "toml",
                    "vim",
                }
            }
        end
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { "nvim-lua/plenary.nvim" },

        config = function()
            require("telescope").setup {
                defaults = {
                    mappings = {
                        n = {
                            ["H"]       = { "^", type = "command" },
                            ["L"]       = { "$", type = "command" },
                            ["<tab>"]   = "move_selection_worse",
                            ["<s-tab>"] = "move_selection_better",
                        },

                        i = {
                            ["<tab>"]   = "move_selection_worse",
                            ["<s-tab>"] = "move_selection_better",
                        }
                    }
                }
            }
        end
    }

    -- Lualine
    use {
        "nvim-lualine/lualine.nvim",

        config = function()
            -- custom colors
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

            -- Define options and sections
            require("lualine").setup {
                options = {
                    section_separators      = { left = "", right = "" },
                    component_separators    = { left = "", right = "" },

                    theme = {
                        normal = {
                            a = { fg = colors.black, bg = colors.yellow, gui = "bold"   },
                            b = { fg = colors.white, bg = colors.black                  },
                            c = { fg = colors.white, bg = colors.gray                   },
                        },

                        insert      = { a = { fg = colors.black,  bg = colors.blue,     gui = "bold" } },
                        visual      = { a = { fg = colors.black,  bg = colors.green,    gui = "bold" } },
                        replace     = { a = { fg = colors.black,  bg = colors.magenta,  gui = "bold" } },
                        command     = { a = { fg = colors.black,  bg = colors.orange,   gui = "bold" } },
                        terminal    = { a = { fg = colors.black,  bg = colors.purple,   gui = "bold" } },
                        inactive    = { c = { fg = colors.yellow, bg = colors.gray                   } },
                    }
                },

                sections = {
                    lualine_a = { "mode"                                                        },
                    lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_lsp" } } },
                    lualine_c = { { "filename", newfile_status = true }                         },
                    lualine_x = { { "filetype", colored = false }                               },
                    lualine_y = { "encoding"                                                    },
                    lualine_z = { "progress", "location"                                        },
                },

                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { { "filetype", colored = false }, "location" },
                    lualine_y = {},
                    lualine_z = {},
                }
            }
        end
    }

    -- Highlight colors
    use {
        "brenoprata10/nvim-highlight-colors",

        config = function()
            require("nvim-highlight-colors").setup {
                render = "background"
            }
        end
    }

    -- Indent blankline
    use {
        "lukas-reineke/indent-blankline.nvim",

        config = function()
            require("indent_blankline").setup {
                indent_level                    = 10,
                max_indent_increase             = 1,
                show_first_indent_level         = false,
                show_trailing_blankline_indent  = false,
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
            require("gitsigns").setup {
                signcolumn = true,
                numhl = true
            }
        end
    }

    -- Autopairs
    use {
        "windwp/nvim-autopairs",

        config = function()
            require("nvim-autopairs").setup()
        end
    }

    -- VimWiki
    use {
        "vimwiki/vimwiki",

        config = function()
            vim.g.vimwiki_global_ext = 0
            vim.g.vimwiki_list = { {
                path        = "~/git-repos/vimwiki/notes/",
                path_html   = "~/git-repos/vimwiki/html/",
            } }
        end
    }

    -- Emmet
    use {
        "mattn/emmet-vim",
        ft = { "html", "css", "php" }
    }

    -- others
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    use "tpope/vim-fugitive"
    use "kyazdani42/nvim-web-devicons"
end

-- Initialize packer
require("packer").startup(packer_startup)
