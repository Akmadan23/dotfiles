return function()
    -- Assign parsers to unsupported filetypes
    local ft_parser = require("nvim-treesitter.parsers").filetype_to_parsername
    ft_parser.zsh = "bash"
    ft_parser.xml = "html"

    -- Setup treesitter
    require("nvim-treesitter.configs").setup {
        highlight   = { enable = true },
        autotag     = { enable = true },
        endwise     = { enable = true },

        refactor = {
            smart_rename            = { enable = true },
            highlight_definitions   = { enable = true }
        },

        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "commonlisp",
            "go",
            "haskell",
            "html",
            "java",
            "javascript",
            "json",
            "julia",
            "latex",
            "lua",
            "make",
            "perl",
            "php",
            "python",
            "r",
            "ruby",
            "rust",
            "scheme",
            "sql",
            "toml",
            "vim",
            "zig",
        }
    }
end
