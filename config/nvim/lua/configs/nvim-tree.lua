local fmt = string.format
local real_keymaps = {}

-- Use a single string for both calling functions and keymaps description
local simple_keymaps = {
    mf  = "fs.create",
    yy  = "fs.copy.node",
    yn  = "fs.copy.filename",
    yp  = "fs.copy.relative_path",
    yP  = "fs.copy.absolute_path",
    dd  = "fs.cut",
    pp  = "fs.paste",
    cw  = "fs.rename_basename",
    cW  = "fs.rename",
    DD  = "fs.trash",
    T   = "marks.toggle",
    i   = "node.show_info_popup",
    l   = "node.open.preview",
    s   = "node.open.horizontal",
    S   = "node.open.vertical",
    t   = "node.open.tab",
    h   = "node.navigate.parent_close",
    gn  = "node.navigate.git.next",
    gN  = "node.navigate.git.prev",
    H   = "tree.change_root_to_parent",
    L   = "tree.change_root_to_node",
    C   = "tree.collapse_all",
    E   = "tree.expand_all",
    ["?"] = "tree.toggle_help",
    ["."] = "tree.toggle_hidden_filter",
    ["#"] = "tree.toggle_git_clean_filter",
    ["/"] = "live_filter.start",
    ["<bs>"] = "live_filter.clear",
}

local on_attach = function(bufnr)
    -- Set custom highlight groups for NvimTree windows
    vim.schedule(function()
        local winnr = require("nvim-tree.view").get_winnr()

        if winnr ~= nil then
            local ns = vim.api.nvim_create_namespace("NvimTree")
            vim.api.nvim_win_set_hl_ns(winnr, ns)
            vim.api.nvim_set_hl(ns, "Normal", { fg = "#F8F8F2", bg = "#272822" })
        else
            vim.notify("Unable to retrieve current NvimTree winnr")
        end
    end)

    if #real_keymaps == 0 then
        for key, value in pairs(simple_keymaps) do
            local callback = loadstring("require('nvim-tree.api')." .. value .. "()")
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
    end

    for _, k in ipairs(real_keymaps) do
        vim.keymap.set("n", k[1], k[2], { buffer = bufnr, desc = k[3] })
    end
end

return function()
    require("nvim-tree").setup {
        on_attach = on_attach,
        live_filter = {
            always_show_folders = false,
        },
        renderer = {
            indent_markers = {
                enable = true,
            },
        },
        help = {
            sort_by = "desc",
        },
        ui = {
            confirm = {
                trash = false,
            },
        },
    }
end
