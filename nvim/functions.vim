" Compile function for C, C++, Go, Rust and Java
function! Compile()
    if &ft == "c"
        !gcc % -o %:r
    elseif &ft == "cpp"
        !g++ % -o %:r
    elseif &ft == "go"
        silent ![ -x "/bin/go" ]
        if v:shell_error == 0
            !go build %
        else
            echoe "Go is not installed."
        endif
    elseif &ft == "nim"
        silent ![ -x "/bin/nim" ]
        if v:shell_error == 0
            !nim c %
        else
            echoe "Nim is not installed."
        endif
    elseif &ft == "rust"
        silent ![ -x "/bin/rustc" ]
        if v:shell_error == 0
            !rustc %
        else
            echoe "Rust is not installed."
        endif
    elseif &ft == "java"
        silent ![ -x "/bin/javac" ]
        if v:shell_error == 0
            if expand("%:p:h:t") == "src"
                !javac % -d %:p:h:h/bin
            else
                !javac %
            endif
        else
            echoe "Java is not installed."
        endif
    elseif &ft == "tex"
        silent ![ -x "/bin/pdflatex" ]
        if v:shell_error == 0
            !pdflatex %
            echoe "LaTeX is not installed."
        endif
    elseif &ft == "lilypond"
        silent ![ -x "/bin/lilypond" ]
        if v:shell_error == 0
            cd %:h
            !lilypond '%'
            cd -
        else
            echoe "Lilypond is not installed."
        endif
    elseif getline(1) =~# "^#!.*/bin/.*sh$"
        silent ![ -x "/bin/shellcheck" ]
        if v:shell_error == 0
            !shellcheck %
        else
            echoe "Shellcheck is not installed."
        endif
    else
        echo "WARNING: Nothing to compile."
    endif
endfunction

" Run function for C, C++, Go, Rust, Java compiled code and any script
function! Run()
    if &ft == "c" || &ft == "cpp" || &ft == "go" || &ft == "nim" || &ft == "rust"
        silent ![ -x %:p:r ]
        if v:shell_error == 0
            split term://%:p:r
        else
            echoe "No " . expand("%:p:r") . " executable file."
        endif
    elseif &ft == "java"
        if expand("%:p:h:t") == "src"
            cd %:p:h:h/bin
        else
            cd %:h
        endif
        split term://java %:t:r
        cd -
    elseif &ft == "python"
        silent ![ -x %:h/__init__.py ]
        if v:shell_error == 0
            cd %:p:h/..
            split term://python -m %:p:h:t.%:t:r
            cd -
        else
            split term://python %
        endif
    elseif &ft == "lisp"
        split term://clisp %
    elseif getline(1) =~# "^#!.*/bin/.*$"
        silent ![ -x % ]
        if v:shell_error == 1
            silent !chmod +x %
        endif
        split term://%:p
    elseif &ft == "tex" || &ft == "lilypond"
        if exists("$READER")
            silent !$READER %:r.pdf & disown
        else
            echoe "You must set the $READER environment variable."
        endif
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
