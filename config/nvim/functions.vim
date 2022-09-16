" Compile function for C, C++, Go, Rust, Java, LaTeX and Lilypond
function! Compile()
    if &ft == "c"
        !gcc '%' -o '%:r'
    elseif &ft == "cpp"
        !g++ '%' -o '%:r'
    elseif &ft == "go"
        if executable("go")
            !go build '%' -o '%:r'
        else
            echo "Go is not installed."
        endif
    elseif &ft == "rust"
        if executable("rustc")
            !rustc '%' -o '%:r'
        else
            echo "Rust is not installed."
        endif
    elseif &ft == "java"
        if executable("javac")
            if expand("%:p:h:t") == "src"
                !javac % -d %:p:h:h/bin
            else
                !javac %
            endif
        else
            echo "Java is not installed."
        endif
    elseif &ft == "tex"
        if executable("pdflatex")
            !pdflatex '%' -output-directory '%:h'
        else
            echo "LaTeX is not installed."
        endif
    elseif &ft == "lilypond"
        if executable("lilypond")
            !lilypond '%' -o '%:r'
        else
            echo "Lilypond is not installed."
        endif
    elseif getline(1) =~# "^#!.*/bin/.*sh$"
        if executable("shellcheck")
            !shellcheck '%'
        else
            echo "Shellcheck is not installed."
        endif
    else
        echo "WARNING: Nothing to compile."
    endif
endfunction

" Run function for Java, any precompiled code and any script
function! Run()
    if &ft == "c" || &ft == "cpp" || &ft == "go" || &ft == "rust"
        silent ![ -x %:r ]
        if v:shell_error == 0
            split term://./%:r
        else
            echo "No " . expand("%:r") . " executable file."
        endif
    elseif &ft == "java"
        if executable("java")
            if expand("%:p:h:t") == "src"
                cd %:p:h:h/bin
            else
                cd %:h
            endif
            split term://java %:t:r
            cd -
        else
            echo "Java is not installed."
        endif
    elseif &ft == "python"
        if executable("python")
            let l:parent = expand("%:p:h")
            if filereadable(l:parent . "/__init__.py")
                cd %:p:h:h
                if filereadable(l:parent . "/__main__.py")
                    split term://python -m %:p:h:t
                else
                    split term://python -m %:p:h:t.%:t:r
                endif
                cd -
            else
                split term://python '%'
            endif
        else
            echo "Python is not installed."
        endif
    elseif &ft == "lua"
        if executable("lua")
            split term://lua '%'
        else
            echo "Lua is not installed."
        endif
    elseif &ft == "tex" || &ft == "lilypond"
        if exists("$READER")
            if filereadable(expand("%:r") . ".pdf")
                silent !$READER '%:r.pdf' & disown
            else
                echo "File '%:r.pdf' not found."
            endif
        else
            echo "You must set the $READER environment variable."
        endif
    elseif getline(1) =~# "^#!/"
        silent ![ -x % ]
        if v:shell_error == 1
            silent !chmod +x %
        endif
        split term://./%
    else
        echo "WARNING: Nothing to execute."
    endif
endfunction

" Custom mappings for FZF
function! FZF_map()
    tno <buffer><esc>   <c-c>
    tno <buffer><tab>   <up>
    tno <buffer><s-tab> <down>
endfunction
