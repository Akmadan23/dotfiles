local opts = {
    -- General
    tgc         = true,
    showmode    = false,
    backup      = false,
    wrap        = false,
    number      = true,
    incsearch   = true,
    ignorecase  = true,
    cursorline  = true,
    background  = "dark",
    clipboard   = "unnamedplus",
    completeopt = "menuone",
    mouse       = "a",

    -- Splits
    splitbelow = true,
    splitright = true,

    -- Tabs
    expandtab   = true,
    tabstop     = 4,
    shiftwidth  = 4,

    -- Indent
    smartindent = true,
    autoindent  = true,

    -- Folding
    foldmethod  = "indent",
    foldenable  = false,
    foldlevel   = 64,
    foldnestmax = 8,
}

-- Initialize each option
for key, value in pairs(opts) do
    vim.o[key] = value
end
