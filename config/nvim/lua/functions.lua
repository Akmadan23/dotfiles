-- Save some typing effort
local fmt = string.format
local exp = vim.fn.expand
local is_exe = vim.fn.executable

local echo = function(obj, opts)
    vim.api.nvim_echo({{ vim.inspect(obj) }}, true, opts or {})
end

local is_file = function(f)
    return vim.fn.filereadable(f) == 1
end

local notify = function(msg)
    vim.notify(msg, vim.log.WARN)
end

-- Module to be exported
local M = {}

---Find the root directory of current project
---@param file string
---@param path string|nil
---@return string|nil
M.root_dir = function(file, path)
    if path == nil then
        path = "%:p"
    end

    local exp_path = exp(path)

    if is_file(fmt("%s/%s", exp_path, file)) then
        return exp_path
    elseif exp_path == "/" then
        return
    else
        return M.root_dir(file, path .. ":h")
    end
end

------------------------------------------
--               COMPILE                --
------------------------------------------

local compile = {}

compile.c = function()
    return "gcc -o '%:r' '%'"
end

compile.cpp = function()
    return "g++ -o '%:r' '%'"
end

compile.go = function()
    if is_exe("go") then
        return "go build -o '%:r' '%'"
    end

    notify("Go is not installed.")
end

compile.java = function()
    if is_exe("javac") then
        if exp("%:p:h:t") == "src" then
            return "javac '%' -d '%:p:h:h/bin'"
        else
            return "javac '%'"
        end
    end

    notify("Java is not installed.")
end

compile.javascript = function()
    local root = M.root_dir("package.json")

    if is_exe("npm") and root then
        local opts = {
            split = true
        }

        if vim.fn.getcwd():match(root) == nil then
            vim.cmd.cd(root)
            opts.jump_back = true
        end

        return "npm run build", opts
    end

    notify("NPM is not installed")
end

compile.typescript = compile.javascript

compile.lilypond = function()
    if is_exe("lilypond") then
        return "lilypond -o '%:r' '%'"
    end

    notify("Lilypond is not installed.")
end

compile.nim = function()
    if is_exe("nim") then
        return "nim compile -o:'%:r' '%'"
    end

    notify("Nim is not installed.")
end

compile.ocaml = function()
    local root = M.root_dir("dune-project")

    if is_exe("dune") and root then
        local opts = {
            split = true
        }

        if vim.fn.getcwd():match(root) == nil then
            vim.cmd.cd(root)
            opts.jump_back = true
        end

        return "dune build", opts
    elseif is_exe("ocamlopt") then
        return "ocamlopt -o '%:r' '%'"
    end

    notify("OCaml is not installed.")
end

compile.rust = function()
    local root = M.root_dir("Cargo.toml")

    if is_exe("cargo") and root then
        local opts = {
            split = true
        }

        if vim.fn.getcwd():match(root) == nil then
            vim.cmd.cd(root)
            opts.jump_back = true
        end

        return "cargo build", opts
    elseif is_exe("rustc") then
        return "rustc -o '%:r' '%'"
    end

    notify("Rust is not installed.")
end

compile.tex = function()
    if is_exe("pdflatex") then
        return "pdflatex '%' -output-directory '%:h'"
    end

    notify("LaTeX is not installed.")
end

compile.dot = function()
    if is_exe("dot") then
        return "dot '%' -Tpdf > '%:r.pdf'"
    end

    notify("Dot is not installed.")
end

compile.zig = function()
    if is_exe("zig") then
        return "zig build-exe '%' -femit-bin='%:r'"
    end

    notify("Zig is not installed.")
end

--- Compile current file
M.compile = function()
    if compile[vim.o.ft] then
        local cmd, opts = compile[vim.o.ft]()

        if cmd then
            if opts == nil then
                opts = {}
            end

            if opts.split then
                cmd = "split term://" .. cmd
            else
                cmd = "!" .. cmd
            end

            vim.cmd(cmd)

            if opts.jump_back then
                vim.cmd.cd("-")
            end
        end
    else
        notify(fmt("Unable to compile %s files.", vim.o.ft))
    end
end

------------------------------------------
--                 RUN                  --
------------------------------------------

local run = {}

run.bin = function()
    local bin_path = exp("%:r")

    if os.execute("test -x " .. bin_path) == 0 then
        return "./%:r"
    end

    notify(fmt("executable file '%s' not found.", bin_path))
end

run.rust = function()
    local root = M.root_dir("Cargo.toml")

    if is_exe("cargo") and root then
        local cmd = "cargo run"
        local opts = {}

        if os.execute(fmt("cargo check --bin=%s &> /dev/null", exp("%:t:r"))) == 0 then
            cmd = cmd .. " --bin=%:t:r"
        end

        if vim.fn.getcwd():match(root) == nil then
            vim.cmd.cd(root)
            opts.jump_back = true
        end

        return cmd, opts
    end

    return run.bin()
end

run.java = function()
    if is_exe("java") then
        local path = "%:h"
        local opts = { jump_back = true }

        if exp("%:p:h:t") == "src" then
            path = "%:p:h:h/bin"
        end

        vim.cd(path)
        return "java %:t:r", opts
    end

    notify("Java SDK is not installed.")
end

run.javascript = function()
    local root = M.root_dir("package.json")

    if is_exe("npm") and root then
        local opts = {}

        if vim.fn.getcwd():match(root) == nil then
            vim.cmd.cd(root)
            opts.jump_back = true
        end

        return "npm run", opts
    elseif is_exe("node") then
        return "node '%'"
    end
end

run.typescript = run.javascript

run.python = function()
    if is_exe("python") then
        local cmd = "python"
        local parent = exp("%:p:h")

        if is_file(parent .. "/__init__.py") then
            local opts = { jump_back = true }
            vim.cmd.cd("%:p:h:h")

            if is_file(parent .. "/__main__.py") then
                cmd = cmd .. " -m %:p:h:t"
            else
                cmd = cmd .. " -m %:p:h:t.%:t:r"
            end

            return cmd, opts
        else
            return cmd .. " '%'"
        end
    end

    notify("Python is not installed.")
end

run.perl = function()
    if is_exe("perl") then
        return "perl '%'"
    end

    notify("Perl is not installed.")
end

run.ruby = function()
    if is_exe("ruby") then
        return "ruby '%'"
    end

    notify("Ruby is not installed.")
end

run.lua = function()
    if is_exe("luajit") then
        return "luajit '%'"
    elseif is_exe("lua") then
        return "lua '%'"
    end

    notify("Lua is not installed.")
end

run.ocaml = function()
    if is_exe("ocaml") then
        return "ocaml '%'"
    end

    notify("OCaml is not installed.")
end

run.lisp = function()
    if is_exe("sbcl") then
        return "sbcl --script '%'"
    elseif is_exe("clisp") then
        return "clisp '%'"
    end

    notify("sbcl nor clisp are installed.")
end

run.sh = function()
    local file_path = exp("%")
    os.execute(fmt("test -x %s || chmod +x %s", file_path, file_path))
    return "./%"
end

run.bash = run.sh
run.zsh = run.sh

run.tex = function()
    if os.getenv("READER") then
        local pdf_path = fmt("%s.pdf", exp("%:r"))

        if is_file(pdf_path) then
            os.execute(fmt("$READER '%s' & disown", pdf_path))
        else
            notify(fmt("File '%s' not found.", pdf_path))
        end
    else
        notify("The $READER environment variable is not set.")
    end
end

run.dot = run.tex
run.lilypond = run.tex

--- Run current file if executable or corresponding compiled file
M.run = function(args)
    local cmd, opts

    if run[vim.o.ft] then
        cmd, opts = run[vim.o.ft]()
    elseif tostring(vim.fn.getline(1)):match("^#!/.*$") then
        cmd = run.sh()
    else
        cmd = run.bin()
    end

    if cmd then
        vim.cmd.split("term://" .. cmd .. (args or ""))

        if opts then
            if opts.jump_back then
                vim.cmd.cd("-")
            end
        end
    end
end

-- Wrapper for M.run with option to pass arguments
M.run_with_args = function()
    vim.ui.input({ prompt = "Args: " }, function(input)
        if input then
            M.run(" " .. input)
        end
    end)
end

------------------------------------------
--                 TEST                 --
------------------------------------------

local test = {}

test.go = function()
    if is_exe("go") then
        return "go test"
    end
end

test.rust = function()
    local root = M.root_dir("Cargo.toml")

    if is_exe("cargo") and root then
        local opts = {}

        if vim.fn.getcwd():match(root) == nil then
            vim.cmd.cd(root)
            opts.jump_back = true
        end

        return "cargo test", opts
    end
end

test.javascript = function()
    local root = M.root_dir("package.json")

    if is_exe("npm") and root then
        local opts = {}

        if vim.fn.getcwd():match(root) == nil then
            vim.cmd.cd(root)
            opts.jump_back = true
        end

        return "npm test", opts
    end
end

test.typescript = test.javascript

test.sh = function()
    if is_exe("shellcheck") then
        return "shellcheck '%'"
    end

    notify("Shellcheck is not installed.")
end

test.bash = test.sh
test.zsh = test.sh

--- Test function for Go, Rust and Shell
M.test = function()
    local cmd, opts

    if test[vim.o.ft] then
        cmd, opts = test[vim.o.ft]()
    elseif tostring(vim.fn.getline(1)):match("^#!/.*sh$") then
        cmd = test.sh()
    end

    if cmd then
        vim.cmd.split("term://" .. cmd)

        if opts then
            if opts.jump_back then
                vim.cmd.cd("-")
            end
        end
    else
        notify("Nothing to test")
    end
end

--- A convenient way to inspect lua objects on the fly
M.inspect_object = function()
    local opts = {
        prompt = "Inspect: ",
        completion = "lua"
    }

    vim.ui.input(opts, function(input)
        if input == nil then
            return
        end

        local f = loadstring("return " .. input)
        vim.api.nvim_out_write("\n")

        if f then
            -- vim.print(f()) -- for some reason it does not work
            echo(f())
        else
            notify("Error parsing lua: Syntax error.")
        end
    end)
end

return M
