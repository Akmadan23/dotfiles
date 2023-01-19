return {
    { -- Automatic insert mode in terminal buffers
        event = "BufNew",
        opts = {
            pattern = "term://*",
            callback = function()
                vim.o.nu = false
                vim.o.rnu = false
                vim.cmd.startinsert()
            end
        }
    },

    { -- Compile packer when writing `plugins.lua` file
        event = "BufWritePost",
        opts = {
            pattern = os.getenv("HOME") .. "/.config/nvim/lua/plugins.lua",
            callback = function(args)
                vim.schedule(function()
                    vim.cmd.source(args.file)
                    require("packer").compile()
                    print("Packer compiled successfully.")
                end)
            end
        }
    }
}
