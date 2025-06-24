local fn = require("functions")
local toggle = require("utils.toggle")

-- Useful constants
local L = "<Leader>"
local NOP = "<NOP>"

return {
    n = {
        -- Disable horizontal mouse scrolling
        ["<ScrollWheelLeft>"]  = NOP,
        ["<ScrollWheelRight>"] = NOP,

        -- Disable q, Q and U
        ["q"] = NOP,
        ["Q"] = NOP,
        ["U"] = NOP,

        -- Map <Leader>q to q
        [L.."q"] = "q",

        -- Join lines with dj
        ["dj"] = "J",

        -- gf to new tab
        ["gf"] = "<C-W>gf",

        -- Move between splits
        ["<C-H>"] = "<C-W>h",
        ["<C-J>"] = "<C-W>j",
        ["<C-K>"] = "<C-W>k",
        ["<C-L>"] = "<C-W>l",

        -- Select all
        ["<C-A>"] = "ggVG",

        -- InspectTree
        ["<C-T>"] = fn.inspect_tree,

        -- LSP shortcuts
        ["grr"] = vim.lsp.buf.rename,
        [L.."i"] = vim.lsp.buf.hover,
        [L.."ca"] = vim.lsp.buf.code_action,
        [L.."cw"] = function() vim.lsp.buf.rename(vim.fn.input("New name: ")) end,

        -- Show highlight info about token under cursor
        [L.."h"] = vim.show_pos,

        -- Buffers navigation
        [L.."bn"] = vim.cmd.bn,
        [L.."bp"] = vim.cmd.bp,

        -- Hide search highlights
        ["<BS>"] = vim.cmd.nohl,

        -- Automatic centering when cycling between search highlights
        ["n"] = "nzz",
        ["N"] = "Nzz",

        -- Move between tabs
        ["<Tab>"]   = "gt",
        ["<S-Tab>"] = "gT",

        -- Inspect lua object on the fly
        [L.."vi"] = fn.inspect_object,

        -- Toggles
        [L.."tw"] = toggle.wrap,
        [L.."ti"] = toggle.ignorecase,
        [L.."ts"] = toggle.shiftwidth,

        -- Lazy
        [L.."lh"] = function() require("lazy").home() end,
        [L.."ls"] = function() require("lazy").sync() end,
        [L.."lp"] = function() require("lazy").profile() end,

        -- Notify
        [L.."nd"] = function() require("notify").dismiss() end,

        -- Guess indent
        [L.."gi"] = function() require("guess-indent").set_from_buffer() end,

        -- NvimTree
        ["<C-E>"] = function() require("nvim-tree.api").tree.toggle { path = vim.fn.expand("%:h") } end,

        -- GitSigns
        ["gbt"] = function() require("gitsigns").toggle_current_line_blame() end,
        ["gbl"] = function() require("gitsigns").blame_line { full = true } end,
        ["ghp"] = function() require("gitsigns").preview_hunk() end,
        ["ghr"] = function() require("gitsigns").reset_hunk() end,
        ["gn"]  = function() require("gitsigns").nav_hunk("next") end,
        ["gN"]  = function() require("gitsigns").nav_hunk("prev") end,

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

    n_v = {
        -- Start/end of line with H/L
        ["H"] = "^",
        ["L"] = "$",

        -- PageUp/PageDown with J/K
        ["J"] = "<C-D>zz",
        ["K"] = "<C-U>zz",

        -- Increase/decrease numeric values
        ["+"] = "<C-A>",
        ["-"] = "<C-X>",

        ["<c-s-.>"] = "q:",
    },

    i_s = {
        -- Disable PageUp and PageDown
        ["<PageUp>"]   = NOP,
        ["<PageDown>"] = NOP,

        -- LuaSnip
        ["<C-N>"] = function() require("luasnip").jump(1) end,
        ["<C-P>"] = function() require("luasnip").jump(-1) end,
    },

    t = {
        -- Terminal bindings
        ["<Esc>"] = "<C-\\><C-N>",
    }
}
