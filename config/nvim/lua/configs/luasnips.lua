return function()
    local ls = require("luasnip")
    local fmt = require("luasnip.extras.fmt").fmt
    local i = ls.insert_node

    local snips = {
        rust = {
            mr = {
                string = [[
                    match {1} {{
                        Ok({2}) => {4},
                        Err({3}) => {5},
                    }}
                ]],

                nodes = {
                    i(1, "condition"),
                    i(2, "arg"),
                    i(3, "arg"),
                    i(4, "todo!(\"if Ok\"),"),
                    i(5, "todo!(\"if Err\"),")
                }
            },

            mo = {
                string = [[
                    match {1} {{
                        Some({2}) => {3},
                        None => {4},
                    }}
                ]],

                nodes = {
                    i(1, "condition"),
                    i(2, "arg"),
                    i(3, "todo!(\"if Some\"),"),
                    i(4, "todo!(\"if None\"),")
                }
            }
        }
    }

    for ft, s in pairs(snips) do
        local snip = {}

        for trigger, v in pairs(s) do
            table.insert(snip, ls.snippet(trigger, fmt(v.string, v.nodes or {}, v.opts or {})))
        end

        ls.add_snippets(ft, snip)
    end
end
