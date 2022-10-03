local fmt = string.format

-- Compile function for C, C++, Go, Rust, Nim, Zig, Java, LaTeX and Lilypond
Compile = function()
    local case = {
        c = function()
            vim.cmd "!gcc -o '%:r' '%'"
        end,

        cpp = function()
            vim.cmd "!g++ -o '%:r' '%'"
        end,

        go = function()
            if vim.fn.executable "go" then
                vim.cmd "!go build -o '%:r' '%'"
            else
                print "Go is not installed."
            end
        end,

        rust = function()
            if vim.fn.executable "rustc" then
                vim.cmd "!rustc -o '%:r' '%'"
            else
                print "Rust is not installed."
            end
        end,

        nim = function()
            if vim.fn.executable "nim" then
                vim.cmd "!nim compile -o:'%:r' '%'"
            else
                print "Nim is not installed."
            end
        end,

        zig = function()
            if vim.fn.executable "zig" then
                vim.cmd "!zig build-exe '%' -femit-bin='%:r'"
            else
                print "Zig is not installed."
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
        print(fmt("Unable to compile %s.", vim.o.ft))
    end
end

-- Run function for Java, Python, Perl, Ruby, Lua, LaTeX, Lilypond and any binary file
Run = function()
    -- Determine if a file exists
    local file_exists = function(path)
        local f = io.open(path)
        return f ~= nil and io.close(f)
    end

    local case = {
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

        perl = function()
            if vim.fn.executable "perl" then
                vim.cmd "split term://perl '%'"
            else
                print "Perl is not installed."
            end
        end,

        ruby = function()
            if vim.fn.executable "ruby" then
                vim.cmd "split term://ruby '%'"
            else
                print "Ruby is not installed."
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
                local pdf_path = vim.fn.expand("%:r") .. ".pdf"

                if file_exists(pdf_path) then
                    os.execute(fmt("$READER '%s' & disown", pdf_path))
                else
                    print(fmt("File '%s' not found.", pdf_path))
                end
            else
                print "The $READER environment variable is not set."
            end
        end,

        bin = function()
            local bin_path = vim.fn.expand "%:r"

            if os.execute(fmt("[ -x %s ]", bin_path)) == 0 then
                vim.cmd "split term://./%:r"
            else
                print(fmt("Executable file '%s' not found.", bin_path))
            end
        end,
    }

    -- Create duplicates in `case` table
    case.c          = case.bin
    case.cpp        = case.bin
    case.go         = case.bin
    case.rust       = case.bin
    case.nim        = case.bin
    case.zig        = case.bin
    case.lilypond   = case.tex

    if case[vim.o.ft] then
        case[vim.o.ft]()
    elseif vim.fn.getline(1):find("^#!/.*$") then
        local file_path = vim.fn.expand "%"

        if os.execute(fmt("[ -x %s ]", file_path)) == 0 then
            os.execute(fmt("chmod +x %s", file_path))
        end

        vim.cmd "split term://./%"
    else
        print "WARNING: Nothing to execute."
    end
end
