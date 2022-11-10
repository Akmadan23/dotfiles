-- Define packer's startup function
local packer_startup = function(use)
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "lewis6991/impatient.nvim"
    use "tpope/vim-fugitive"
    use "tpope/vim-repeat"

    -- LSP
    use {
        "neovim/nvim-lspconfig",

        config = function()
            -- Language servers
            local srv = {
                "bashls",
                "clangd",
                "emmet_ls",
                "gopls",
                "nimls",
                "phpactor",
                "pyright",
                "quick_lint_js",
                "sqls",
                "sumneko_lua",
                "texlab",
                "vimls",
            }

            -- Suppress warning "Undefined global `vim`" in lua
            local lua_settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT"
                    },

                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }

            -- Setup nvim-lsp
            for _, i in pairs(srv) do
                require("lspconfig")[i].setup {
                    settings = (i == "sumneko_lua") and lua_settings or nil
                }
            end
        end
    }

    -- Completion
    use {
        "hrsh7th/nvim-cmp",

        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        },

        config = function()
            local cmp = require "cmp"

            -- Setup nvim-cmp
            cmp.setup {
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip"  },
                    { name = "path",    trailing_slash = true },
                    { name = "buffer",  keyword_length = 5 },
                },

                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
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
                        mode = "symbol_text",
                        menu = {
                            nvim_lsp    = "[LSP]",
                            luasnip     = "[SNIP]",
                            path        = "[PATH]",
                            buffer      = "[BUF]",
                        }
                    }
                }
            }

            -- Cmdline and path source for ':'
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources {
                    { name = "cmdline", keyword_length = 5 },
                    { name = "path" },
                }
            })
        end
    }

    -- Snippets
    use {
        "L3MON4D3/LuaSnip",
        tag = "v1.*",

        config = function()
            local ls = require("luasnip")
            local fmt = require("luasnip.extras.fmt").fmt
            local i = ls.insert_node

            local snips = {
                rust = {
                    mr = {
                        string = [[
                            match xy {
                                Ok(xy) => xy,
                                Err(xy) => xy,
                            }
                        ]],

                        nodes = {
                            i(1, "condition"),
                            i(2, "arg"),
                            i(4, "/* if Ok */"),
                            i(3, "arg"),
                            i(0, "/* if Err */")
                        },

                        opts = {
                            delimiters = "xy"
                        }
                    },

                    mo = {
                        string = [[
                            match xy {
                                Some(xy) => xy,
                                None => xy,
                            }
                        ]],

                        nodes = {
                            i(1, "condition"),
                            i(2, "arg"),
                            i(3, "/* if Some */"),
                            i(0, "/* if None */")
                        },

                        opts = {
                            delimiters = "xy"
                        }
                    }
                }
            }

            for ft, s in pairs(snips) do
                local snip = {}

                for trigger, v in pairs(s) do
                    table.insert(snip, ls.snippet(trigger, fmt(v.string, v.nodes or {}, v.opts or {})))
                end

                ls.add_snippets(ft, snip)
            end
        end
    }

    -- JDTLS
    use {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },

        config = function()
            -- Custom paths
            local path = {
                jar = "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
                config = "/usr/share/java/jdtls/config_linux",
                data = os.getenv "XDG_DATA_HOME" .. "/jdtls/",
            }

            -- Initialize JDTLS
            require("jdtls").start_or_attach {
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

                    "-jar",             path.jar,
                    "-configuration",   path.config,
                    "-data",            path.data,
                },

                -- This is the default if not provided, you can remove it. Or adjust as needed.
                -- One dedicated LSP server & client will be started per unique root_dir
                root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew" },
            }
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
        commit = "4cccb6f",
        run = ":TSUpdate",

        requires = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-refactor",
            "RRethy/nvim-treesitter-endwise",
            "windwp/nvim-ts-autotag",
        },

        config = function()
            -- Assign parsers to unsupported filetypes
            local ft_parser = require("nvim-treesitter.parsers").filetype_to_parsername
            ft_parser.zsh = "bash"
            ft_parser.xml = "html"

            require("nvim-treesitter.configs").setup {
                highlight   = { enable = true },
                autotag     = { enable = true },
                endwise     = { enable = true },

                refactor = {
                    smart_rename            = { enable = true },
                    highlight_definitions   = { enable = true }
                },

                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "commonlisp",
                    "go",
                    "haskell",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "julia",
                    "latex",
                    "lua",
                    "make",
                    "perl",
                    "php",
                    "python",
                    "r",
                    "ruby",
                    "rust",
                    "scheme",
                    "sql",
                    "toml",
                    "vim",
                    "zig",
                }
            }
        end
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",

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

            -- Change filename module's color when the file is modified
            local filename_color = function()
                if vim.bo.modified then
                    return {
                        fg = colors.magenta,
                        gui = "bold",
                    }
                else
                    return nil
                end
            end

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
                    lualine_b = { { "filename", newfile_status = true, color = filename_color } },
                    lualine_c = { "branch", "diff", { "diagnostics", sources = { "nvim_lsp" } } },
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

    -- Comment
    use {
        "numToStr/Comment.nvim",

        config = function()
            require("Comment").setup {
                ignore = "^$",
            }
        end
    }

    -- Autopairs
    use {
        "windwp/nvim-autopairs",

        config = function()
            local autopairs = require "nvim-autopairs"
            local rule = require "nvim-autopairs.rule"

            -- Symmetric padding in brackets
            local padding = function(opts)
                local pair = opts.line:sub(opts.col - 1, opts.col)
                return vim.tbl_contains({ "()", "[]", "{}" }, pair)
            end

            -- Setup autopairs
            autopairs.setup()

            -- Set autopairs additional rules
            autopairs.add_rules {
                rule(" ", " "):with_pair(padding)
            }
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
end

-- Initialize packer
require("packer").startup(packer_startup)
