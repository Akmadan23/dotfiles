-- Use cache for faster startup if `impatient` is installed
if not pcall(require, "impatient") then
    vim.schedule(function()
        print "Impatient.nvim is not installed"
    end)
end

-- Set leader key
vim.g.mapleader = " "

-- Disable custom keymaps in man buffers
vim.g.no_man_maps = 1

-- Set colorscheme
vim.cmd "color monokai"

-- List of command abbreviations
local abbr = {
    "W", "Q",
    "WQ", "Wq",
    "WA", "Wa",
    "QA", "Qa",
    "WQA", "WQa", "Wqa"
}

for _, a in ipairs(abbr) do
    vim.cmd(("cabbrev %s %s"):format(a, a:lower()))
end

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
