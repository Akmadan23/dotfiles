-- Save some typing effort
local fmt = string.format

-- Split declaration and initialization to enable recursion
local file_exists, root_dir, case

-- Determine if a file exists
file_exists = function(path)
    local f = io.open(path)
    return f ~= nil and io.close(f)
end

-- Find the root directory of current project
root_dir = function(path, file)
    if file_exists(fmt("%s/%s", vim.fn.expand(path), file)) then
        return true
    elseif vim.fn.expand(path) == "." then
        return false
    else
        return root_dir(path .. ":h", file)
    end
end

-- Virtual switch/case statement
case = {
    compile = {
        c = function()
            vim.cmd("!gcc -o '%:r' '%'")
        end,

        cpp = function()
            vim.cmd("!g++ -o '%:r' '%'")
        end,

        go = function()
            if vim.fn.executable("go") then
                vim.cmd("!go build -o '%:r' '%'")
            else
                print("Go is not installed.")
            end
        end,

        rust = function()
            if vim.fn.executable("cargo") and root_dir("%", "Cargo.toml") then
                vim.cmd("!cargo build")
            elseif vim.fn.executable("rustc") then
                vim.cmd("!rustc -o '%:r' '%'")
            else
                print("Rust is not installed.")
            end
        end,

        nim = function()
            if vim.fn.executable("nim") then
                vim.cmd("!nim compile -o:'%:r' '%'")
            else
                print("Nim is not installed.")
            end
        end,

        zig = function()
            if vim.fn.executable("zig") then
                vim.cmd("!zig build-exe '%' -femit-bin='%:r'")
            else
                print("Zig is not installed.")
            end
        end,

        java = function()
            if vim.fn.executable("javac") then
                if vim.fn.expand("%:p:h:t") == "src" then
                    vim.cmd("!javac '%' -d '%:p:h:h/bin'")
                else
                    vim.cmd("!javac '%'")
                end
            else
                print("Java is not installed.")
            end
        end,

        tex = function()
            if vim.fn.executable("pdflatex") then
                vim.cmd("!pdflatex '%' -output-directory '%:h'")
            else
                print("LaTeX is not installed.")
            end
        end,

        lilypond = function()
            if vim.fn.executable("lilypond") then
                vim.cmd("!lilypond -o '%:r' '%'")
            else
                print("Lilypond is not installed.")
            end
        end,

        shell = function()
            if vim.fn.executable("shellcheck") then
                vim.cmd("!shellcheck '%'")
            else
                print("Shellcheck is not installed.")
            end
        end
    },

    run = {
        bin = function()
            local bin_path = vim.fn.expand("%:r")

            if os.execute(fmt("[ -x %s ]", bin_path)) == 0 then
                vim.cmd.split("term://./%:r")
            else
                print(fmt("executable file '%s' not found.", bin_path))
            end
        end,

        rust = function()
            if vim.fn.executable("cargo") and root_dir("%", "Cargo.toml") then
                if os.execute(fmt("cargo check --bin=%s &> /dev/null", vim.fn.expand("%:t:r"))) == 0 then
                    vim.cmd.split("term://cargo run --bin=%:t:r")
                else
                    vim.cmd.split("term://cargo run")
                end
            else
                case.run.bin()
            end
        end,

        java = function()
            if vim.fn.executable("java") then
                if vim.fn.expand("%:p:h:t") == "src" then
                    vim.cmd.cd("%:p:h:h/bin")
                else
                    vim.cmd.cd("%:h")
                end

                vim.cmd.split("term://java %:t:r")
                vim.cmd.cd("-")
            else
                print("Java is not installed.")
            end
        end,

        python = function()
            if vim.fn.executable("python") then
                local parent = vim.fn.expand("%:p:h")

                if file_exists(parent .. "/__init__.py") then
                    vim.cmd.cd("%:p:h:h")

                    if file_exists(parent .. "/__main__.py") then
                        vim.cmd.split("term://python -m %:p:h:t")
                    else
                        vim.cmd.split("term://python -m %:p:h:t.%:t:r")
                    end

                    vim.cmd.cd("-")
                else
                    vim.cmd.split("term://python %")
                end
            else
                print("Python is not installed.")
            end
        end,

        perl = function()
            if vim.fn.executable("perl") then
                vim.cmd.split("term://perl '%'")
            else
                print("Perl is not installed.")
            end
        end,

        ruby = function()
            if vim.fn.executable("ruby") then
                vim.cmd.split("term://ruby '%'")
            else
                print("Ruby is not installed.")
            end
        end,

        lua = function()
            if vim.fn.executable("luajit") then
                vim.cmd.split("term://luajit '%'")
            elseif vim.fn.executable("lua") then
                vim.cmd.split("term://lua '%'")
            else
                print("Lua is not installed.")
            end
        end,

        lisp = function()
            if vim.fn.executable("sbcl") then
                vim.cmd.split("term://sbcl --script '%'")
            elseif vim.fn.executable("clisp") then
                vim.cmd.split("term://clisp '%'")
            else
                print("sbcl or clisp is not installed.")
            end
        end,

        pdf = function()
            if os.getenv("READER") then
                local pdf_path = vim.fn.expand("%:r") .. ".pdf"

                if file_exists(pdf_path) then
                    os.execute(fmt("$READER '%s' & disown", pdf_path))
                else
                    print(fmt("File '%s' not found.", pdf_path))
                end
            else
                print("The $READER environment variable is not set.")
            end
        end,

        default = function()
            local file_path = vim.fn.expand("%")
            os.execute(fmt("[ -x %s ] || chmod +x %s", file_path, file_path))
            vim.cmd.split("term://./%")
        end
    },

    test = {
        go = function()
            if vim.fn.executable("go") then
                vim.cmd.split("term://go test")
            else
                print("Go is not installed.")
            end
        end,

        rust = function()
            if vim.fn.executable("cargo") then
                vim.cmd.split("term://cargo test")
            else
                print("Cargo is not installed.")
            end
        end
    }
}

return {
    -- Compile function for C, C++, Go, Rust, Nim, Zig, Java, LaTeX and Lilypond
    compile = function()
        if case.compile[vim.o.ft] then
            case.compile[vim.o.ft]()
        elseif vim.fn.getline(1):find("^#!/.*sh$") then
            case.compile.shell()
        else
            print(fmt("Unable to compile %s files.", vim.o.ft))
        end
    end,

    -- Run function for Java, Python, Perl, Ruby, Lua, Common Lisp, LaTeX, Lilypond and any binary file
    run = function()
        if case.run[vim.o.ft] then
            case.run[vim.o.ft]()
        elseif vim.tbl_contains({ "c", "cpp", "go", "rust", "nim", "zig" }, vim.o.ft) then
            case.run.bin()
        elseif vim.tbl_contains({ "tex", "lilypond" }, vim.o.ft) then
            case.run.pdf()
        elseif vim.fn.getline(1):find("^#!/.*$") then
            case.run.default()
        else
            print("WARNING: Nothing to execute.")
        end
    end,

    -- Test function for Go and Rust
    test = function()
        if case.test[vim.o.ft] then
            case.test[vim.o.ft]()
        else
            print("WARNING: Nothing to test")
        end
    end
}
