return function()
    local lint = require("lint")

    lint.linters_by_ft = {
        cpp = { "cppcheck" }
    }

    vim.api.nvim_create_autocmd({ "BufNew", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("NvimLint", {}),
        pattern = "*.cpp",
        callback = function()
            lint.try_lint("cppcheck")
        end
    })
end
