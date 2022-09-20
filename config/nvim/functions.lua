-- Compile function for C, C++, Go, Rust, Java, LaTeX and Lilypond
Compile = function()
    local case = {
        c = function()
            vim.cmd "!gcc '%' -o '%:r'"
        end,

        cpp = function()
            vim.cmd "!g++ '%' -o '%:r'"
        end,

        go = function()
            if vim.fn.executable "go" then
                vim.cmd "!go build '%' -o '%:r'"
            else
                print "Go is not installed."
            end
        end,

        rust = function()
            if vim.fn.executable "rustc" then
                vim.cmd "!rustc '%' -o '%:r'"
            else
                print "Rust is not installed."
            end
        end,

        java = function()
            if vim.fn.executable "javac" then
                if vim.fn.expand "%:p:h:t" == "src" then
                    vim.cmd "!javac '%' -d '%:p:h:h/bin'"
                else
                    vim.cmd "!javac '%'"
                end
            else
                print "Java is not installed."
            end
        end,

        tex = function()
            if vim.fn.executable "pdflatex" then
                vim.cmd "!pdflatex '%' -output-directory '%:h'"
            else
                print "LaTeX is not installed."
            end
        end,

        lilypond = function()
            if vim.fn.executable "lilypond" then
                vim.cmd "!lilypond '%' -o '%:r'"
            else
                print "Lilypond is not installed."
            end
        end,
    }

    if case[vim.o.ft] then
        case[vim.o.ft]()
    elseif vim.fn.getline(1):find("^#!/.*sh$") then
        if vim.fn.executable "shellcheck" then
            vim.cmd "!shellcheck '%'"
        else
            print "Shellcheck is not installed."
        end
    else
        print(("Unable to compile %s."):format(vim.o.ft))
    end
end

-- Run function for Java, any precompiled code and any script
Run = function()
    -- Determine if a file exists
    local file_exists = function(path)
        local f = io.open(path)
        return f ~= nil and io.close(f)
    end

    local case = {
        c = function()
            vim.cmd "silent ![ -x %:r ]"

            if vim.v.shell_error == 0 then
                vim.cmd "split term://./%:r"
            else
                print(("Executable file '%s' not found."):format(vim.fn.expand "%:r"))
            end
        end,

        java = function()
            if vim.fn.executable "java" then
                if vim.fn.expand "%:p:h:t" == "src" then
                    vim.cmd "cd %:p:h:h/bin"
                else
                    vim.cmd "cd %:h"
                end

                vim.cmd "split term://java %:t:r"
                vim.cmd "cd -"
            else
                print "Java is not installed."
            end
        end,

        python = function()
            if vim.fn.executable "python" then
                local parent = vim.fn.expand "%:p:h"

                if file_exists(parent .. "/__init__.py") then
                    vim.cmd "cd %:p:h:h"

                    if file_exists(parent .. "/__main__.py") then
                        vim.cmd "split term://python -m %:p:h:t"
                    else
                        vim.cmd "split term://python -m %:p:h:t.%:t:r"
                    end

                    vim.cmd "cd -"
                else
                    vim.cmd "split term://python %"
                end
            else
                print "Python is not installed."
            end
        end,

        lua = function()
            if vim.fn.executable "lua" then
                vim.cmd "split term://lua '%'"
            else
                print "Lua is not installed."
            end
        end,

        tex = function()
            if os.getenv "READER" then
                local pdf = vim.fn.expand("%:r") .. ".pdf"

                if file_exists(pdf) then
                    vim.cmd "silent !$READER '%:r.pdf' & disown"
                else
                    print(("File %s not found."):format(pdf))
                end
            else
                print "The $READER environment variable is not set."
            end
        end,
    }

    -- Create duplicates in `case` table
    case.cpp        = case.c
    case.go         = case.c
    case.rust       = case.c
    case.lilypond   = case.tex

    if case[vim.o.ft] then
        case[vim.o.ft]()
    elseif vim.fn.getline(1):find("^#!/.*sh$") then
        vim.cmd "silent ![ -x % ]"

        if vim.v.shell_error == 1 then
            vim.cmd "silent !chmod +x %"
        end

        vim.cmd "split term://./%"
    else
        print "WARNING: Nothing to execute."
    end
end
