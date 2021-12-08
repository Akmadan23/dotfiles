" Compile function for C, C++, Go, Rust and Java
function! Compile()
    let l:ext = expand('%:e')
    if l:ext == 'c'
        !gcc % -o %:r
    elseif l:ext == 'cpp'
        !g++ % -o %:r
    elseif l:ext == 'go'
        !go build %
    elseif l:ext == 'rs'
        !rustc %
    elseif l:ext == 'java'
        !javac %
    elseif l:ext == 'tex'
        !pdflatex %
    elseif l:ext == 'ly'
        !lilypond %
    elseif getline(1) =~# '^#!.*/bin/.*sh$'
        silent ![ -x /bin/shellcheck ]
        if v:shell_error == 0
            !shellcheck %
        else
            echo 'ERROR: Shellcheck is not installed.'
        endif
    else
        echo 'ERROR: Nothing to compile.'
    endif
endfunction

" Run function for C, C++, Go, Rust, Java compiled code and any script
function! Run()
    if getline(1) =~# '^#!.*/bin/.*$'
        silent ![ -x % ]
        if v:shell_error == 1
            silent !chmod +x %
        endif
        split term://%:p
    else
        let l:ext = expand('%:e')
        if l:ext == 'c' || l:ext == 'cpp' || l:ext == 'go' || l:ext == 'rs'
            silent ![ -x %:p:r ]
            if v:shell_error == 0
                split term://%:p:r
            else
                echo 'ERROR: No "'.expand('%:p:r').'" executable file.'
            endif
        elseif l:ext == 'java'
            cd %:h
            split term://java %:r
        elseif l:ext == 'tex' || l:ext == 'ly'
            if exists('$READER')
                silent !$READER %:p:r.pdf & disown
            else
                echo 'ERROR: You must set the $READER environment variable.'
            endif
        else
            echo 'ERROR: Nothing to execute.'
        endif
    endif
endfunction

" Calling functions
nmap <F5> <cmd>call Compile()<CR>
nmap <F6> <cmd>call Run()<CR>
