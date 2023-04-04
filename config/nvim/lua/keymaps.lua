local L = "<leader>"

return {
    n = {
        -- Disable q, Q and U
        ["q"] = false,
        ["Q"] = false,
        ["U"] = false,

        -- Map <leader>q to q
        [L.."q"] = "q",

        -- Paste in visual mode without losing the last clipboard register
        [L.."p"] = "\"_dP",

        -- Join lines with dj
        ["dj"] = "J",

        -- Select all
        ["<c-a>"] = "ggVG",

        -- LSP shortcuts
        ["grr"] = vim.lsp.buf.rename,
        ["gd"] = vim.lsp.buf.definition,
        [L.."i"] = vim.lsp.buf.hover,
        [L.."ca"] = vim.lsp.buf.code_action,

        -- Hide search highlights
        ["<bs>"] = vim.cmd.nohl,

        -- Automatic centering when cycling between search highlights
        ["n"] = "nzz",
        ["N"] = "Nzz",

        -- Move between tabs
        ["<tab>"]   = "gt",
        ["<s-tab>"] = "gT",

        -- Toggle wrap and ignorecase
        ["<a-w>"] = function() vim.o.wrap = not vim.o.wrap; print("Wrap:", vim.o.wrap) end,
        ["<a-i>"] = function() vim.o.ic = not vim.o.ic; print("Ignorecase:", vim.o.ic) end,

        -- Telescope
        [L.."ff"] = function() require("telescope.builtin").find_files() end,
        [L.."fr"] = function() require("telescope.builtin").oldfiles() end,
        [L.."fm"] = function() require("telescope.builtin").man_pages() end,
        [L.."fh"] = function() require("telescope.builtin").help_tags() end,
        [L.."fb"] = function() require("telescope.builtin").builtin() end,

        -- Packer
        [L.."pi"] = function() require("packer").install() end,
        [L.."pc"] = function() require("packer").clean() end,
        [L.."ps"] = function() require("packer").sync() end,

        -- Trouble
        [L.."t"] = function() require("trouble").toggle() end,

        -- Custom functions
        ["<f5>"] = function() require("functions").compile() end,
        ["<f6>"] = function() require("functions").run() end,
        ["<f7>"] = function() require("functions").test() end,
    },

    v = {
        -- Visual tabbing
        ["<tab>"]   = ">gv",
        ["<s-tab>"] = "<gv",
    },

    n_v = {
        -- Disable Ctrl+Z and the space bar
        ["<c-z>"]   = false,
        ["<space>"] = false,

        -- Start/end of line with H/L
        ["H"] = "^",
        ["L"] = "$",

        -- PageUp/PageDown with J/K
        ["J"] = "<c-d>zz",
        ["K"] = "<c-u>zz",

        -- Increase/decrease numeric values
        ["+"] = "<c-a>",
        ["-"] = "<c-x>",
    },

    i_s = {
        -- Disable PageUp and PageDown
        ["<pageup>"]   = false,
        ["<pagedown>"] = false,

        -- LuaSnip
        ["<c-n>"] = function() require("luasnip").jump(1) end,
        ["<c-p>"] = function() require("luasnip").jump(-1) end,
    },

    t = {
        -- Terminal bindings
        ["<esc>"] = "<c-\\><c-n>",
    },
}
