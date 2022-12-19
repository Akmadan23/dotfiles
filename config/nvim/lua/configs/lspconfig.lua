return function()
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
