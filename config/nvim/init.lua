-- Set leader key
vim.g.mapleader = " "

-- Disable custom keymaps in man buffers
vim.g.no_man_maps = true

-- Add filetypes
vim.filetype.add {
    extension = {
        rasi = "rasi",
        yuck = "yuck",
    }
}

-- Add lazy to runtime path
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazy_path)

-- Set lazy options
local lazy_config = {
    install = {
        missing = false
    }
}

-- Initialize lazy
require("lazy").setup("plugins", lazy_config)

-- Initialize options
for key, value in pairs(require("options")) do
    vim.o[key] = value
end

-- Create autocmds
for _, a in ipairs(require("autocmds")) do
    vim.api.nvim_create_autocmd(a.event, a.opts)
end

-- Set keymaps
for mode, keymaps in pairs(require("keymaps")) do
    for key, value in pairs(keymaps) do
        vim.keymap.set(mode, key, value, { silent = true })
    end
end

-- Command abbreviations
for _, a in ipairs { "W", "Q", "WQ", "Wq", "WA", "Wa", "QA", "Qa", "WQA", "WQa", "Wqa" } do
    vim.cmd {
        cmd = "cabbrev",
        args = { a, a:lower() }
    }
end

-- Set colorscheme
vim.cmd.colorscheme("monokai")
