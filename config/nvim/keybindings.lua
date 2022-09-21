-- Leader key
vim.g.mapleader = " "

-- Default options for each keymap
local opts = {
    silent = true,
    noremap = true,
}

-- Generic function to set each keymap
local map = function(mode, key, value)
    -- If mode has more than one chars
    if #mode > 1 then
        -- Initialize an empty table
        local mode_table = {}

        -- For each char create a table item
        for i = 1, #mode do
            mode_table[i] = mode:sub(i, i)
        end

        -- Replace the old string with the table
        mode = mode_table
    end

    -- Run the actual keymap command
    vim.keymap.set(mode, key, value, opts)
end

-- Start/end of line with H/L
map("nv",   "H",            "^")
map("nv",   "L",            "$")

-- PageUp/PageDown with J/K
map("nv",   "J",            "<c-d>zz")
map("nv",   "K",            "<c-u>zz")

-- Disable Q and map <c-q> to q
map("n",    "<c-q>",        "q")
map("n",    "Q",            "<nop>")
map("n",    "q",            function() print "For macros and cmdwin use <c-q>" end)

-- Redo with U
map("n",    "U",            "<c-r>")

-- Fix Y behaviour
map("n",    "Y",            "y$")

-- Join lines with dj
map("n",    "dj",           "J")

-- Automatic centering when cycling between search highlights
map("nv",   "n",            "nzz")

-- Hide search highlights
map("n",    "<bs>",         "<cmd>nohlsearch<cr>")

-- Toggle wrap
map("n",    "<a-w>",        function() vim.o.wrap = not vim.o.wrap; print("Wrap:", vim.o.wrap) end)

-- Select all
map("n",    "<c-a>",        "ggVG")

-- Move between splits
map("n",    "<c-h>",        "<c-w>h")
map("n",    "<c-j>",        "<c-w>j")
map("n",    "<c-k>",        "<c-w>k")
map("n",    "<c-l>",        "<c-w>l")

-- Move between tabs
map("n",    "<tab>",        "gt")
map("n",    "<s-tab>",      "gT")

-- Visual tabbing
map("v",    "<tab>",        ">gv")
map("v",    "<s-tab>",      "<gv")

-- Increase/decrease numeric values
map("nv",   "<a-+>",        "<c-a>")
map("nv",   "<a-->",        "<c-x>")

-- Telescope
map("n",    "<leader>tf",   "<cmd>Telescope find_files<cr>")
map("n",    "<leader>tm",   "<cmd>Telescope man_pages<cr>")
map("n",    "<leader>tb",   "<cmd>Telescope builtin<cr>")

-- Packer
map("n",    "<leader>pc",   "<cmd>PackerCompile<cr>")
map("n",    "<leader>ps",   "<cmd>PackerSync<cr>")
map("n",    "<leader>pi",   "<cmd>PackerInstall<cr>")

-- Custom functions
map("n",    "<f5>",         "<cmd>lua Compile()<cr>")
map("n",    "<f6>",         "<cmd>lua Run()<cr>")

-- Disable keys
map("nv",   "<space>",      "<nop>")
map("nv",   "<c-z>",        "<nop>")

-- Terminal bindings
map("t",    "<esc>",        "<c-\\><c-n>")
