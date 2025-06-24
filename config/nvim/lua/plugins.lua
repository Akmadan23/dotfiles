local L = "<Leader>"

return {
    { "nvim-lua/plenary.nvim",              lazy = true },
    { "nvim-tree/nvim-web-devicons",        lazy = true },
    { "debugloop/telescope-undo.nvim",      lazy = true },
    { "folke/neodev.nvim",  version = "*",  lazy = true },
    {   -- Notify
        "rcarriga/nvim-notify",
        priority = 60,
        version = "*",
        cond = not vim.g.started_by_firenvim,
        config = function()
            vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })
            vim.notify = require("notify")
        end
    },
    {   -- LSP
        "neovim/nvim-lspconfig",
        cond = not vim.g.started_by_firenvim,
        config = require("configs.lspconfig"),
    },
    {   -- Lint
        "mfussenegger/nvim-lint",
        cond = false,
        config = require("configs.lint"),
    },
    {   -- Fidget
        "j-hui/fidget.nvim",
        cond = false,
        tag = "legacy",
        event = "LspAttach",
        opts = {
            text = {
                spinner = "meter"
            },
            window = {
                blend = 0
            },
        },
    },
    {   -- CMP
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = require("configs.cmp"),
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        },
    },
    {   -- Snippets
        "L3MON4D3/LuaSnip",
        cond = not vim.g.started_by_firenvim,
        version = "*",
        event = "InsertEnter",
        config = require("configs.luasnips"),
    },
    {   -- JDTLS
        "mfussenegger/nvim-jdtls",
        version = "*",
        ft = "java",
        config = require("configs.jdtls"),
    },
    {   -- Rust tools
        "simrat39/rust-tools.nvim",
        ft = "rust",
        opts = {},
    },
    {   -- Crates
        "Saecki/crates.nvim",
        version = "*",
        event = "BufRead Cargo.toml",
        opts = {},
    },
    {   -- Trouble
        "folke/trouble.nvim",
        version = "*",
        opts = {
            indent_lines = false,
            auto_close = true,
            focus = true,
        },
        keys = {
            { L.."d", function() require("trouble").toggle { mode = "diagnostics" } end },
        },
    },
    {   -- Treesitter
        "nvim-treesitter/nvim-treesitter",
        version = "*",
        build = ":TSUpdate",
        config = require("configs.treesitter"),
        -- commit = "fa414da",
        -- commit = "203981d",
        dependencies = {
            "RRethy/nvim-treesitter-endwise",
        }
    },
    {   -- Telescope
        "nvim-telescope/telescope.nvim",
        version = "*",
        config = require("configs.telescope"),
        keys = require("configs.telescope.keys"),
    },
    {   -- Nvim tree
        "nvim-tree/nvim-tree.lua",
        dev = true,
        cond = not vim.g.started_by_firenvim,
        config = require("configs.nvim-tree"),
    },
    {   -- Lualine
        "nvim-lualine/lualine.nvim",
        cond = not vim.g.started_by_firenvim,
        config = require("configs.lualine"),
    },
    {   -- Highlight colors
        "brenoprata10/nvim-highlight-colors",
        opts = {
            enable_named_colors = false,
            render = "background"
        },
    },
    {   -- Indent blankline
        "lukas-reineke/indent-blankline.nvim",
        version = "*",
        main = "ibl",
        opts = {
            indent = {
                char = "▏",
                tab_char = "⇀"
            },
            scope = {
                enabled = false
            }
        },
    },
    {   -- Guess indent
        "NMAC427/guess-indent.nvim",
        cond = not vim.g.started_by_firenvim,
        opts = {},
    },
    {   -- Git signs
        "lewis6991/gitsigns.nvim",
        event = "User LoadGitSigns",
        init = require("configs.gitsigns"),
        opts = {},
    },
    {   -- Comment
        "numToStr/Comment.nvim",
        version = "*",
        event = "VeryLazy",
        opts = {
            ignore = "^$"
        },
    },
    {   -- Autopairs
        "altermo/ultimate-autopair.nvim",
        -- commit = "b1cbb66",
        event = "InsertEnter",
        opts = {
            bs = {
                overjump = false
            },
            cr = {
                addsemi = false
            },
        },
    },
    {   -- Surround
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    {   -- Hop
        "phaazon/hop.nvim",
        event = "VeryLazy",
        opts = {
            keys = "asdfghjklqwertyuiopzxcvbnm"
        },
        keys = {
            { "\\", function() require("hop").hint_char1() end },
        },
    },
    {   -- Scratchpad
        "Akmadan23/scratchpad.nvim",
        cond = not vim.g.started_by_firenvim,
        event = "VeryLazy",
        opts = {},
        keys = {
            { "<F2>", function() require("scratchpad").toggle() end }
        },
    },
    {   -- Local session
        "Akmadan23/local-session.nvim",
        cond = not vim.g.started_by_firenvim,
        opts = {},
    },
}
