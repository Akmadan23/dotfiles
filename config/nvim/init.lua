-- Set colorscheme
vim.cmd.colorscheme("monokai")

-- Set leader key
vim.g.mapleader = " "

-- Disable custom keymaps in man buffers
vim.g.no_man_maps = true

-- Disable netrw on startup
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

-- Add filetypes
vim.filetype.add {
    extension = {
        rasi = "rasi",
        map = "xml",
    },
}

-- Initialize options
for k, v in pairs(require("options")) do
    vim.api.nvim_set_option_value(k, v, {})
end

-- Add lazy to runtime path
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazy_path)

-- Set lazy options
local lazy_config = {
    dev = {
        path = "~/git-repos/",
        patterns = { "Akmadan23" },
    },
    install = {
        missing = false,
    },
    ui = {
        border = "double",
    },
}

-- Initialize lazy
require("lazy").setup("plugins", lazy_config)

-- Create autocmds
for _, a in ipairs(require("autocmds")) do
    vim.api.nvim_create_autocmd(a.event, a.opts)
end

-- Set keymaps
for mode, keymaps in pairs(require("keymaps")) do
    if #mode > 1 then
        ---@diagnostic disable-next-line: cast-local-type
        mode = vim.split(mode, "_")
    end

    for key, value in pairs(keymaps) do
        vim.keymap.set(mode, key, value, { silent = true })
    end
end

-- Command abbreviations
for _, a in ipairs { "W", "Q", "WQ", "Wq", "WA", "Wa", "QA", "Qa", "WQA", "WQa", "Wqa" } do
    vim.cmd {
        cmd = "cabbrev",
        args = { a, a:lower() },
    }
end
