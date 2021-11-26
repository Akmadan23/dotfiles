" Compile function for C, C++, Go, Rust and Java
function! Compile()
    let l:ext = expand('%:e')
    if ext == 'c'
        exec '!gcc % -o %:r'
    elseif ext == 'cpp'
        exec '!g++ % -o %:r'
    elseif ext == 'go'
        exec '!go build %'
    elseif ext == 'rs'
        exec '!rustc %'
    elseif ext == 'java'
        exec '!javac %'
    elseif getline(1) =~# '^#!.*/bin/.*sh$'
        silent exec '![ -x /bin/shellcheck ]'
        if v:shell_error == 0
            exec '!shellcheck %'
        else
            echo 'Shellcheck is not installed.'
        endif
    else
        echo 'Nothing to compile.'
    endif
endfunction

" Run function for C, C++, Go, Rust, Java compiled code and any script
function! Run()
    if getline(1) =~# '^#!.*/bin/.*$'
        silent exec '![ -x % ]'
        if v:shell_error == 1
            silent exec '!chmod +x %'
        endif
        split term://%:p
    else
        let l:ext = expand('%:e')
        if l:ext == 'c' || l:ext == 'cpp' || l:ext == 'go' || l:ext == 'rs'
            split term://%:p:r
        elseif l:ext == 'java'
            cd %:h
            split term://java %:r
        else
            echo 'Nothing to execute.'
        endif
    endif
endfunction

" Calling functions
nmap <silent><F5> :call Compile()<CR>
nmap <silent><F6> :call Run()<CR>
