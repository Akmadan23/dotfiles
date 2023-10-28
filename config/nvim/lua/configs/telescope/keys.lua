local L = "<Leader>"

local builtin = function(fn, arg)
    return function()
        require("telescope.builtin")[fn](arg)
    end
end

local ext = function(name)
    return function()
        require("telescope").extensions[name][name]()
    end
end

return {
    { L.."ff", builtin("find_files")        },
    { L.."fr", builtin("oldfiles")          },
    { L.."fm", builtin("man_pages")         },
    { L.."fh", builtin("help_tags")         },
    { L.."fb", builtin("builtin")           },
    { L.."gd", builtin("lsp_definitions",   { jump_type = "tab" }) },
    { L.."gr", builtin("lsp_references")    },
    { L.."nl", ext("notify")                },
    { L.."u",  ext("undo")                  },
}
