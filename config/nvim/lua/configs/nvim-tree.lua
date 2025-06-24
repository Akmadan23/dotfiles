local fmt = string.format
local real_keymaps = {}

-- Use a single string for both calling functions and keymaps description
local simple_keymaps = {
    mf      = "fs.create",
    yy      = "fs.copy.node",
    yn      = "fs.copy.filename",
    yp      = "fs.copy.relative_path",
    yP      = "fs.copy.absolute_path",
    dd      = "fs.cut",
    pp      = "fs.paste",
    cw      = "fs.rename_basename",
    cW      = "fs.rename",
    DD      = "fs.trash",
    T       = "marks.toggle",
    i       = "node.show_info_popup",
    ["<CR>"]= "node.open.edit",
    l       = "node.open.preview",
    s       = "node.open.horizontal",
    S       = "node.open.vertical",
    t       = "node.open.tab",
    h       = "node.navigate.parent_close",
    gn      = "node.navigate.git.next",
    gN      = "node.navigate.git.prev",
    H       = "tree.change_root_to_parent",
    L       = "tree.change_root_to_node",
    C       = "tree.collapse_all",
    I       = "tree.inspect_node_under_cursor",
    E       = "tree.expand_all",
    ["?"]   = "tree.toggle_help",
    ["."]   = "tree.toggle_hidden_filter",
    ["gi"]  = "tree.toggle_gitignore_filter",
    ["#"]   = "tree.toggle_git_clean_filter",
    ["/"]   = "live_filter.start",
    ["<bs>"]= "live_filter.clear",
}

local on_attach = function(bufnr)
    -- Set custom highlight groups for NvimTree windows
    vim.schedule(function()
        local winnr = require("nvim-tree.view").get_winnr()

        if winnr ~= nil then
            local ns = vim.api.nvim_create_namespace("NvimTree")
            vim.api.nvim_win_set_hl_ns(winnr, ns)
            vim.api.nvim_set_hl(ns, "Normal", { fg = "#F8F8F2", bg = "#272822", default = true })
            -- vim.api.nvim_set_hl(ns, "Normal", { fg = "#6BA63F", bg = "#000000" })
            -- vim.api.nvim_set_hl(ns, "Directory", { fg = "#42AFE6", bold = true })
            -- vim.api.nvim_set_hl(ns, "NvimTreeIndentMarker", { fg = "#96CA6B" })
            -- vim.api.nvim_set_hl(ns, "NvimTreeOpenedFolderIcon", { fg = "#3371BB" })
        else
            vim.notify("Unable to retrieve current NvimTree winnr")
        end
    end)

    if #real_keymaps == 0 then
        for key, value in pairs(simple_keymaps) do
            local callback = loadstring(fmt("require('nvim-tree.api').%s()", value))
            local desc = value
                :gsub("%.", ": ", 1)
                :gsub("%.", " ")
                :gsub("_", " ")

            if callback then
                table.insert(real_keymaps, { key, callback, desc })
            else
                vim.notify(fmt("Error at mapping %q", key))
            end
        end

        local inspect_node_under_cursor = function()
            local node = require("nvim-tree.lib").get_node_at_cursor()
            vim.api.nvim_echo({ { vim.inspect(node) } }, false, {})
        end

        table.insert(real_keymaps, {
            "I",
            inspect_node_under_cursor,
            "tree: inspect node unret cursor",
        })
    end

    for _, k in ipairs(real_keymaps) do
        vim.keymap.set("n", k[1], k[2], { buffer = bufnr, desc = k[3] })
    end
end

local git_diagnostics_modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
}

return function()
    require("nvim-tree").setup {
        on_attach = on_attach,
        git = git_diagnostics_modified,
        modified = git_diagnostics_modified,
        -- diagnostics = git_diagnostics_modified,
        reload_on_bufenter = true,
        log = {
            enable = true,
            -- truncate = true,
            types = {
                dev = true
            }
        },
        help = {
            sort_by = "desc"
        },
        actions = {
            expand_all = {
                exclude = {
                    ".git"
                }
            }
        },
        filters = {
            dotfiles = true,
        },
        live_filter = {
            -- prefix = 1,
            always_show_folders = false
        },
        renderer = {
            group_empty = true,
            --@param path string
            -- group_empty = function(path)
            --     -- return 1
            --     -- return path:gsub('([a-zA-Z])[^/]*/', '%1/')
            --     return path:gsub('([a-zA-Z])[a-z]+', '%1') .. path:gsub('.*[^a-zA-Z].?', '', 1)
            -- end,
            indent_markers = {
                enable = true
            },
            icons = {
                glyphs = {
                    -- default = "󰐆",
                    folder = {
                        default = "",
                        open = ""
                    }
                }
            }
        },
        ui = {
            confirm = {
                trash = false
                -- default_yes = true
            }
        },
    }
end
