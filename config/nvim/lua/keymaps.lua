-- Default options for each keymap
local opts = {
    silent = true,
    noremap = true,
}

-- Generic function to set each keymap
local map = function(mode, key, value)
    -- If mode has more than one char transform it in a table
    if #mode > 1 then
        mode = vim.split(mode, "")
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

-- Disable Q and map <leader>q to q
map("n",    "q",            "<nop>")
map("n",    "Q",            "<nop>")
map("n",    "<leader>q",    "q")

-- Redo with U
map("n",    "U",            "<c-r>")

-- Fix Y behaviour
map("n",    "Y",            "y$")

-- Join lines with dj
map("n",    "dj",           "J")

-- Automatic centering when cycling between search highlights
map("n",    "n",            "nzz")
map("n",    "N",            "Nzz")

-- Hide search highlights
map("n",    "<bs>",         "<cmd>nohlsearch<cr>")

-- Toggle wrap
map("n",    "<a-i>",        "<cmd>set ic!<bar>set ic?<cr>")
map("n",    "<a-w>",        "<cmd>set wrap!<bar>set wrap?<cr>")

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
map("nv",   "+",            "<c-a>")
map("nv",   "-",            "<c-x>")

-- Telescope
map("n",    "<leader>ff",   "<cmd>Telescope find_files<cr>")
map("n",    "<leader>fr",   "<cmd>Telescope oldfiles<cr>")
map("n",    "<leader>fm",   "<cmd>Telescope man_pages<cr>")
map("n",    "<leader>fh",   "<cmd>Telescope help_tags<cr>")
map("n",    "<leader>fb",   "<cmd>Telescope builtin<cr>")

-- Trouble
map("n",    "<leader>t",    "<cmd>TroubleToggle<cr>")

-- Packer
map("n",    "<leader>pi",   "<cmd>PackerInstall<cr>")
map("n",    "<leader>pc",   "<cmd>PackerClean<cr>")
map("n",    "<leader>ps",   "<cmd>PackerSync<cr>")

-- Custom functions
map("n",    "<f5>",         "<cmd>lua Compile()<cr>")
map("n",    "<f6>",         "<cmd>lua Run()<cr>")


-- Terminal bindings
map("t",    "<esc>",        "<c-\\><c-n>")

-- Disable keys
local disabled = {
    { "nv", "<c-z>"         },
    { "nv", "<space>"       },
    { "i",  "<pageup>"      },
    { "i",  "<pagedown>"    },
}

for _, v in ipairs(disabled) do
    map(v[1], v[2], "<nop>")
end
