return function()
    -- Initialize neodev
    require("neodev").setup()

    -- Language servers
    local srv = {
        "bashls",
        "clangd",
        "csharp_ls",
        "emmet_ls",
        "gopls",
        -- "jedi_language_server",
        "lua_ls",
        "ocamllsp",
        "phpactor",
        "pyright",
        -- "pylsp",
        "texlab",
        "ts_ls",
    }

    -- Configurations specific to each language
    local configs = {
        lua_ls = {
            settings = {
                Lua = {
                    -- Enable neodev
                    completion = {
                        callSnippet = "Replace"
                    },
                    -- Suppress warning "Undefined global `vim`" in lua
                    diagnostics = {
                        globals = { "vim" }
                    },
                    -- Set runtime version to `LuaJIT`
                    runtime = {
                        version = "LuaJIT"
                    },
                    -- Disable semantic highlighting
                    semantic = {
                        enable = false
                    },
                    -- Disable third party libraries check
                    workspace = {
                        checkThirdParty = false
                    }
                }
            }
        },
        -- pyright = {
        --     settings = {
        --         pyright = {
        --             disableLanguageServices = true
        --         }
        --     },

        --     handlers = {
        --         ["textDocument/hover"] = function() end
        --     }
        -- }
    }

    -- Setup LSP servers
    for _, s in ipairs(srv) do
        require("lspconfig")[s].setup(configs[s] or {})
    end
end
