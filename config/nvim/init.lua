-- Set leader key
vim.g.mapleader = " "

-- Disable custom keymaps in man buffers
vim.g.no_man_maps = true

-- Import `impatient` and `packer` in a protected call
-- to avoid a bunch of errors if not yet installed
xpcall(function()
    -- Use cache for faster startup
    require("impatient")

    -- Initialize packer
    require("packer").startup(require("plugins"))
end, function(e)
    vim.schedule(function()
        vim.api.nvim_err_writeln(vim.split(e, "\n")[1])
    end)
end)

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
    -- If mode has more than one char transform it in a table
    if #mode > 1 then
        mode = vim.split(mode, "_")
    end

    for key, value in pairs(keymaps) do
        vim.keymap.set(mode, key, value or "<nop>", {
            silent = true,
            noremap = true
        })
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
