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
        "sqlls",
        "texlab",
        "tsserver",
        "vimls",
    }

    -- Setup each LSP server
    for _, s in ipairs(srv) do
        require("lspconfig")[s].setup {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT"
                    },

                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
    end
end
