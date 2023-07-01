local home = os.getenv("HOME")
local group = vim.api.nvim_create_augroup("MyAugroup", {})

return {
    {   -- Automatic insert mode in terminal buffers
        event = "BufNew",
        opts = {
            pattern = "term://*",
            group = group,

            callback = function()
                vim.o.nu = false
                vim.o.rnu = false
                vim.cmd.startinsert()
            end
        }
    },

    {   -- Set tabs to 2 for some filetypes
        event = "FileType",
        opts = {
            pattern = { "json", "query" },
            group = group,

            callback = function()
                vim.bo.shiftwidth = 2
                vim.bo.tabstop = 2
            end
        }
    },

    {   -- Open nvim-tree when editing plugins configuration
        event = "BufEnter",
        opts = {
            pattern = home .. "/.config/nvim/lua/plugins.lua",
            group = group,
            once = true,

            callback = function()
                require("nvim-tree.api").tree.toggle {
                    path = vim.fn.expand("%:h") .. "/configs",
                    focus = false
                }
            end
        }
    }
}
