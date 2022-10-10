-- Save some typing effort
local autocmd = vim.api.nvim_create_autocmd

-- Automatic insert mode in terminal buffers
autocmd("BufEnter", {
    pattern = "term://*",
    callback = function()
        vim.o.number = false
        vim.cmd "startinsert"
    end
})

-- Set filetype to css in rofi stylesheets
autocmd("BufEnter", {
    pattern = "*.rasi",
    callback = function()
        vim.bo.filetype = "css"
    end
})

-- Compile packer when writing `plugins.lua` file
autocmd("BufWritePost", {
    pattern = os.getenv "HOME" .. "/.config/nvim/lua/plugins.lua",
    callback = function()
        local packer_compile = function()
            vim.cmd "source %"
            require("packer").compile()
            print "Packer compiled successfully."
        end

        vim.schedule(packer_compile)
    end
})
