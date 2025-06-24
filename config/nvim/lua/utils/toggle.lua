local meta = {
    __index = function(_, opt)
        return function()
            if type(vim.o[opt]) == "boolean" then
                ---@diagnostic disable-next-line assign-type-mismatch
                vim.o[opt] = not vim.o[opt]
                print(opt .. ":", vim.o[opt])
            else
                print("Option " .. opt .. " can't be toggled")
            end
        end
    end
}

return setmetatable({}, meta)
