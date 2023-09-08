return function()
    local actions = require("telescope-undo.actions")

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
        },

        extensions = {
            undo = {
                mappings = {
                    i = {
                        ["<cr>"]    = actions.restore,
                        ["<s-cr>"]  = actions.yank_additions,
                        ["<c-cr>"]  = actions.yank_deletions,
                    }
                }
            }
        }
    }
end
