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

-- Set comment pattern for lilypond files
autocmd("FileType", {
    pattern = "lilypond",
    callback = function()
        vim.bo.commentstring = "% %s"
    end
})
