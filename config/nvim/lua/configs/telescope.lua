return function()
    require("telescope").setup {
        defaults = {
            mappings = {
                n = {
                    ["H"]       = { "^", type = "command" },
                    ["L"]       = { "$", type = "command" },
                    ["<tab>"]   = "move_selection_worse",
                    ["<s-tab>"] = "move_selection_better",
                },

                i = {
                    ["<tab>"]   = "move_selection_worse",
                    ["<s-tab>"] = "move_selection_better",
                }
            }
        }
    }
end
