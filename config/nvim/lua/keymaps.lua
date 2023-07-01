local fn = require("functions")
local L = "<Leader>"

local toggle = {
    wrap = function()
        vim.o.wrap = not vim.o.wrap
        print("Wrap:", vim.o.wrap)
    end,

    ignorecase = function()
        vim.o.ic = not vim.o.ic
        print("Ignorecase:", vim.o.ic)
    end,

    shiftwidth = function()
        vim.o.sw = (vim.o.sw == 4) and 2 or 4
        print("Shiftwidth:", vim.o.sw)
    end
}

return {
    n = {
        -- Disable horizontal mouse scrolling
        ["<ScrollWheelLeft>"]  = "<NOP>",
        ["<ScrollWheelRight>"] = "<NOP>",

        -- Disable q and Q
        ["q"] = "<NOP>",
        ["Q"] = "<NOP>",
        ["U"] = "<NOP>",

        -- Map <Leader>q to q
        [L.."q"] = "q",

        -- Join lines with dj
        ["dj"] = "J",

        -- Select all
        ["<C-A>"] = "ggVG",

        -- Move between splits
        ["<C-H>"] = "<C-W>h",
        ["<C-J>"] = "<C-W>j",
        ["<C-K>"] = "<C-W>k",
        ["<C-L>"] = "<C-W>l",

        -- LSP shortcuts
        ["grr"] = vim.lsp.buf.rename,
        [L.."i"] = vim.lsp.buf.hover,
        [L.."ca"] = vim.lsp.buf.code_action,

        -- Show highlight info about token under cursor
        [L.."h"] = vim.show_pos,

        -- Hide search highlights
        ["<bs>"] = vim.cmd.nohl,

        -- Automatic centering when cycling between search highlights
        ["n"] = "nzz",
        ["N"] = "Nzz",

        -- Move between tabs
        ["<Tab>"]   = "gt",
        ["<S-Tab>"] = "gT",

        -- Inspect lua object on the fly
        [L.."vi"] = fn.inspect,

        -- Toggles
        [L.."tw"] = toggle.wrap,
        [L.."ti"] = toggle.ignorecase,
        [L.."ts"] = toggle.shiftwidth,

        -- Telescope
        [L.."ff"] = function() require("telescope.builtin").find_files() end,
        [L.."fr"] = function() require("telescope.builtin").oldfiles() end,
        [L.."fm"] = function() require("telescope.builtin").man_pages() end,
        [L.."fh"] = function() require("telescope.builtin").help_tags() end,
        [L.."fb"] = function() require("telescope.builtin").builtin() end,
        [L.."gd"] = function() require("telescope.builtin").lsp_definitions { jump_type = "split" } end,
        [L.."gr"] = function() require("telescope.builtin").lsp_references() end,
        [L.."u"]  = function() require("telescope").extensions.undo.undo() end,

        -- Lazy
        [L.."lh"] = function() require("lazy").home() end,
        [L.."ls"] = function() require("lazy").sync() end,

        -- Trouble
        [L.."d"] = function() require("trouble").toggle() end,

        -- Indent
        [L.."ri"] = function() require("indent_blankline").refresh() end,

        -- NvimTree
        ["<C-E>"] = function() require("nvim-tree.api").tree.toggle { path = vim.fn.expand("%:h") } end,

        -- Compile, run and test
        ["<F5>"]    = fn.compile,
        ["<F6>"]    = fn.run,
        ["<F18>"]   = fn.run_with_args, -- <s-f6>
        ["<F7>"]    = fn.test,
    },

    v = {
        -- Visual tabbing
        ["<Tab>"]   = ">gv",
        ["<S-Tab>"] = "<gv",

        -- Paste in visual mode without losing the last clipboard register
        [L.."p"] = "\"_dP",
    },

    [{ "n", "v" }] = {
        -- Start/end of line with H/L
        ["H"] = "^",
        ["L"] = "$",

        -- PageUp/PageDown with J/K
        ["J"] = "<C-D>zz",
        ["K"] = "<C-U>zz",

        -- Increase/decrease numeric values
        ["+"] = "<C-A>",
        ["-"] = "<C-X>",
    },

    [{ "i", "s" }] = {
        -- Disable PageUp and PageDown
        ["<PageUp>"]   = "<NOP>",
        ["<PageDown>"] = "<NOP>",

        -- LuaSnip
        ["<C-N>"] = function() require("luasnip").jump(1) end,
        ["<C-P>"] = function() require("luasnip").jump(-1) end,
    },

    t = {
        -- Terminal bindings
        ["<Esc>"] = "<C-\\><C-N>",
    }
}
