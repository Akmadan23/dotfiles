-- defining plugins
require("packer").startup {
    function(use)
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
                        {name = "path"},
                        {name = "vsnip"},
                        {name = "buffer"},
                    },

                    formatting = {
                        format = require("lspkind").cmp_format {
                            mode = "symbol_text"
                        }
                    }
                }

                -- Defining language servers (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
                local srv = {
                    "vimls",
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
            end
        }

        -- JDTLS
        use {
            "mfussenegger/nvim-jdtls",
            ft = {"java"},

            config = function()
                local jdtls_config = {
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
                    root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"}),
                }

                -- This starts a new client & server,
                -- or attaches to an existing client & server depending on the `root_dir`.
                require("jdtls").start_or_attach(jdtls_config)
            end
        }

        -- dev tools
        use "jiangmiao/auto-pairs"
        use "tpope/vim-commentary"
        use "tpope/vim-repeat"
        use "tpope/vim-fugitive"
        use "airblade/vim-gitgutter"
        use {"alvan/vim-closetag", ft = {"html", "xml", "php"}}
        use {"mattn/emmet-vim", ft = {"html", "css", "php"}}
        use {"iamcco/markdown-preview.nvim", ft = {"markdown"}, run = "cd app & yarn install"}

        -- appearance
        use "sheerun/vim-polyglot"
        use "rrethy/vim-hexokinase"
        use "ryanoasis/vim-devicons"
        use "powerman/vim-plugin-AnsiEsc"
        use "lukas-reineke/indent-blankline.nvim"
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

                -- defining options and sections
                local lualine_config = {
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

                require("lualine").setup(lualine_config)
            end
        }

        -- utilities
        use "vimwiki/vimwiki"
        use "junegunn/fzf.vim"
    end
}
