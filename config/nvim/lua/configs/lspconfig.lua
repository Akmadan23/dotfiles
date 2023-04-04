return function()
    -- Language servers
    local srv = {
        "bashls",
        "clangd",
        "emmet_ls",
        "gopls",
        "lua_ls",
        "nimls",
        "phpactor",
        "pyright",
        "quick_lint_js",
        "sqls",
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
    for _, s in ipairs(srv) do
        require("lspconfig")[s].setup {
            settings = (s == "lua_ls") and lua_settings or nil
        }
    end
end
