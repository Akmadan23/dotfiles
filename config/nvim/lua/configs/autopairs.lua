return function()
    local autopairs = require("nvim-autopairs")
    local rule = require("nvim-autopairs.rule")

    -- Symmetric padding in brackets
    local padding = function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end

    -- Setup autopairs
    autopairs.setup()

    -- Set autopairs additional rules
    autopairs.add_rules {
        rule(" ", " "):with_pair(padding)
    }
end
