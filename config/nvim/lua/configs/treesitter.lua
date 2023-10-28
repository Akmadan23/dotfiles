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
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup {
        highlight   = ON,
        endwise     = ON,
    }
end
