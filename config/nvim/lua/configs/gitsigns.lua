return function()
    local group = vim.api.nvim_create_augroup("LoadGitSigns", {})

    vim.api.nvim_create_autocmd("BufRead", {
        group = group,

        callback = function()
            local path = vim.fn.expand("%:p:h")
            local cmd = string.format("git -C %s rev-parse 2>/dev/null", path)
            local in_git_repo = os.execute(cmd) == 0

            if in_git_repo then
                vim.cmd.doautocmd("User LoadGitSigns")
                vim.api.nvim_del_augroup_by_id(group)
            end
        end
    })
end
