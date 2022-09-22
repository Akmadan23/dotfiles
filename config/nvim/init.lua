-- List of config file
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

-- Set colorscheme
vim.cmd "color monokai"
