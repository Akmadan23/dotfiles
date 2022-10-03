-- Set leader key
vim.g.mapleader = " "

-- Disable custom keymaps in man buffers
vim.g.no_man_maps = 1

-- Set colorscheme
vim.cmd "color monokai"

-- List of config files
local files = {
    "options",
    "plugins",
    "functions",
    "autocmds",
    "keymaps",
}

-- Import each file
for _, f in ipairs(files) do
    require(f)
end
