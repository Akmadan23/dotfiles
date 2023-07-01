return function()
    require("nvim-tree").setup {
        live_filter = {
            always_show_folders = false,
        },

        renderer = {
            indent_markers = {
                enable = true
            }
        },

        trash = {
            cmd = "trash-put"
        },

        on_attach = function(bufnr)
            -- Set custom highlight groups for NvimTree windows
            vim.schedule(function()
                local ns = vim.api.nvim_create_namespace("NvimTree")
                vim.api.nvim_win_set_hl_ns(require("nvim-tree.view").get_winnr(), ns)
                vim.api.nvim_set_hl(ns, "Normal", { fg = "#F8F8F2", bg = "#272822" })
            end)

            -- Use a single string for both calling functions and keymaps description
            local keymaps = {
                ["grr"] = "fs.rename_basename",
                ["grR"] = "fs.rename",
                ["yy"]  = "fs.copy.node",
                ["yn"]  = "fs.copy.filename",
                ["yp"]  = "fs.copy.relative_path",
                ["yP"]  = "fs.copy.absolute_path",
                ["pp"]  = "fs.paste",
                ["dd"]  = "fs.cut",
                ["DD"]  = "fs.trash",
                ["m"]   = "marks.toggle",
                ["i"]   = "node.show_info_popup",
                ["s"]   = "node.open.horizontal",
                ["S"]   = "node.open.vertical",
                ["t"]   = "node.open.tab",
                ["h"]   = "node.navigate.parent_close",
                ["l"]   = "node.open.preview",
                ["H"]   = "tree.change_root_to_parent",
                ["L"]   = "tree.change_root_to_node",
                ["C"]   = "tree.collapse_all",
                ["E"]   = "tree.expand_all",
                ["?"]   = "tree.toggle_help",
                ["."]   = "tree.toggle_hidden_filter",
                ["#"]   = "tree.toggle_git_clean_filter",
                ["/"]   = "live_filter.start",
                ["<bs>"]= "live_filter.clear",
            }

            for key, value in pairs(keymaps) do
                local callback = loadstring("require('nvim-tree.api')." .. value .. "()")
                vim.keymap.set("n", key, callback, { buffer = bufnr, desc = value })
            end
        end
    }
end
