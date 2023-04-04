return function()
    -- Assign parsers to unsupported filetypes
    local ft_parser = require("nvim-treesitter.parsers").filetype_to_parsername
    ft_parser.zsh = "bash"
    ft_parser.xml = "html"

    -- Setup treesitter
    require("nvim-treesitter.configs").setup {
        highlight   = { enable = true },
        playground  = { enable = true },
        autotag     = { enable = true },
        endwise     = { enable = true },

        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "commonlisp",
            "diff",
            "dot",
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
            "query",
            "r",
            "rasi",
            "ruby",
            "rust",
            "scheme",
            "scss",
            "sql",
            "toml",
            "vim",
            "yuck",
            "zig",
        }
    }
end
