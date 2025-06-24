---@diagnostic disable: missing-fields
return function()
    local cmp = require("cmp")
    local border = cmp.config.window.bordered()

    -- Setup nvim-cmp
    cmp.setup {
        window = {
            completion = border,
            documentation = border,
        },

        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip"  },
            { name = "path",    trailing_slash = true   },
            { name = "buffer",  keyword_length = 5      },
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
                    -- nvim_lua    = "[API]",
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
