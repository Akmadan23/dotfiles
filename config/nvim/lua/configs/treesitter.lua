local ON = { enable = true }

return function()
    -- Assign parsers to unsupported filetypes
    local ft_parser = {
        bash = "zsh",
        html = "xml",
    }

    for parser, ft in pairs(ft_parser) do
        vim.treesitter.language.register(parser, ft)
    end

    -- Setup treesitter
    require("nvim-treesitter.configs").setup {
        highlight   = ON,
        autotag     = ON,
        endwise     = ON,
    }
end
